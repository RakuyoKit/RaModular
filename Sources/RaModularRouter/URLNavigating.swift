//
//  URLNavigating.swift
//  RaModular
//
//  Created by Rakuyo on 2023/03/17.
//  Copyright © 2023 Rakuyo. All rights reserved.
//

import Foundation

import RaModularCore

extension Router: URLNavigating { }

/// Provide logic for registering routes and displaying view controllers through routing.
public protocol URLNavigating {
    /// Registering routes.
    ///
    /// - Parameters:
    ///   - url: The URL corresponding to the routing event, which can also be understood as the unique identifier for the routing event.
    ///   - behavior: The routing event is also the process of creating the target view controller.
    static func register(_ url: RouterURL, with behavior: @escaping RouterBehavior)
    
    /// Open the view controller through the url.
    ///
    /// You need to ensure that the routing behavior corresponding to
    /// this URL has been registered before calling this method.
    ///
    /// For example:
    /// ```
    /// import RaModular
    ///
    /// Router.open("some router url", mode: .show(), animated: true) {
    ///     print("push, then before viewDidAppear; present, then after viewDidAppear.")
    /// }
    /// ```
    ///
    /// - Parameters:
    ///   - url: The URL corresponding to the routing event, which can also be understood as the unique identifier for the routing event.
    ///   - userInfo: Parameters that may be required during some routing processes.
    ///   - mode: The way to open the target controller. See `RouterMode` type for details.
    ///   - animated: Whether to use animation during switching. Support all cases of `RouterMode`.
    ///   - completion: The callback to be executed after the end of the animation. It may not work in some cases.
    static func open(_ url: RouterURL, with userInfo: Parameters, mode: RouterMode?, animated: Bool?, completion: VoidClosure?)
}

// MARK: - Default

public extension URLNavigating {
    static func register(_ url: RouterURL, with behavior: @escaping RouterBehavior) {
        RouterTable[url, isCovered: false] = behavior
    }
    
    static func open(
        _ url: RouterURL,
        with userInfo: Parameters = [:],
        mode: RouterMode? = nil,
        animated: Bool? = nil,
        completion: VoidClosure? = nil
    ) {
        guard let behavior = RouterTable[url] else {
            print("❌ No route table found for the given URL! Please check if the URL is registered. url: \(url)")
            return
        }
        
        var userInfo = userInfo
        // Put the parameters from the url into userInfo for passing.
        // Considering the actual development, should maintain the unity of the logic,
        // so the key of the parameters in the url, can `userInfo` in the possible key should be the same,
        // at this time there should not be a conflict situation.
        //
        // If you have any objections to this realization, please submit issues to me, thank you.
        userInfo = url.query.reduce(into: userInfo) { $0[$1.key] = $1.value }
        
        // If not provided externally, it tries to query from the url parameter and ends up touting the default value.
        lazy var _mode = mode ?? getMode(from: userInfo) ?? .default
        lazy var _animated = animated ?? getAnimated(from: userInfo) ?? true
        
        guard let controller = behavior(url, _mode, userInfo) else {
            print("⚠️ The closure event returns nil instead of a view controller object. This navigation event will be ignored.")
            return
        }
        
        guard let topVisibleViewController = UIApplication.shared.rmd.topVisibleViewController() else {
            print("❌ Failed to retrieve the currently displayed view controller, unable to perform the navigation.")
            return
        }
        
        show(
            controller,
            mode: _mode,
            animated: _animated,
            by: topVisibleViewController,
            completion: completion
        )
    }
}

// MARK: - Public Tools

public extension URLNavigating {
    static func show(
        _ controller: UIViewController,
        mode: RouterMode,
        animated: Bool,
        by topVisibleViewController: UIViewController,
        completion: VoidClosure?
    ) {
        lazy var _navigate: (_ action: VoidClosure) -> Void = {
            guard animated else {
                UIView.performWithoutAnimation($0)
                return
            }
            
            CATransaction.setCompletionBlock(completion)
            CATransaction.begin()
            $0()
            CATransaction.commit()
        }
        
        switch mode {
        case .show(let sender):
            _navigate {
                topVisibleViewController.show(controller, sender: sender)
            }
            
        case .showDetail(let sender):
            _navigate {
                topVisibleViewController.showDetailViewController(controller, sender: sender)
            }
            
        case .push:
            _navigate {
                topVisibleViewController.navigationController?.pushViewController(controller, animated: animated)
            }
            
        case .present:
            topVisibleViewController.present(controller, animated: animated, completion: completion)
        }
    }
}

// MARK: - Private

private extension URLNavigating {
    typealias Key = Router.PredefinedKey
    
    static func getMode(from userInfo: Parameters) -> RouterMode? {
        let value = userInfo[Key.modeType] as? RouterMode.Identifier
        return value.flatMap { RouterMode(identifier: $0) }
    }
    
    static func getAnimated(from userInfo: Parameters) -> Bool? {
        let value = userInfo[Key.animation]
        guard let stringValue = value as? String else { return nil }
        return !{ $0 == "false" || $0 == "0" }(stringValue.lowercased())
    }
}
