//
//  ServicesURLNavigate.swift
//  RaServices
//
//  Created by Rakuyo on 2023/03/17.
//  Copyright © 2023 Rakuyo. All rights reserved.
//

import Foundation

import RaServicesCore

/// Keys that may be used in the navigation process
public enum NavigationPredefinedKey {
    /// The default key used to wrap the parameters in the url.
    public static let urlParameters = "ra_url_parameters"
    
    /// If you want to define the way of navigation in the url, please use this value to define it.
    /// For details, please refer to `NavigationMode.Identifier`.
    public static let modeType = "ra_mode_type"
    
    /// If you want to define in the url whether to use animated display view controllers or not,
    /// use this value to define it.
    ///
    /// Anything non-zero or non-false will be treated as `Swift.Bool.true`
    public static let animation = "ra_animation"
}

/// You can register and navigate routes by type.
extension Navigation: ServicesURLNavigate { }

/// Provides the ability to display a view controller via url.
public protocol ServicesURLNavigate {
    /// Register the navigation behavior into the routing table.
    ///
    /// - Parameters:
    ///   - url: The key of the routing table, the unique identifier corresponding to a certain navigation behavior.
    ///   - action: The value of the routing table, the navigation behavior.
    static func register(_ url: NavigationRouterURL, with action: @escaping NavigationAction)
    
    /// Open the view controller through the url.
    ///
    /// You need to make sure that the navigation behavior corresponding to
    /// the url is registered before calling the method.
    ///
    /// For example:
    /// ```swift
    /// import RaServicesURLNavigate
    ///
    /// Navigation.open("some router url", mode: .show(), animated: true) {
    ///     print("after viewDidAppear")
    /// }
    /// ```
    ///
    /// - Parameters:
    ///   - url: The key of the routing table, the unique identifier corresponding to a certain navigation behavior.
    ///   - userInfo: Some parameters to be passed by the initiator to the target controller.
    ///   - mode: The way to open the target controller. See `NavigationMode` type for details.
    ///   - animated: Whether to use animation during switching. Support all cases of `NavigationMode`.
    ///   - completion: The callback to be executed after the end of the animation. It may not work in some cases.
    static func open(_ url: NavigationRouterURL, with userInfo: Parameters, mode: NavigationMode?, animated: Bool?, completion: VoidClosure?)
    
    /// The framework will parse out the parameters in the url and put them into the `userInfo` parameter,
    /// default implementation will put `urlParameters` under `userInfo[NavigationPredefinedKey.urlParameters]`
    /// if it is not empty.
    ///
    /// This method provides an entry point where you can customize the specific implementation of this behavior.
    /// This will affect where the closure that creates the view controller gets the parameters in the url from.
    ///
    /// - Parameters:
    ///   - urlParameters: The parameters in the url.
    ///   - userInfo: Target value.
    static func parse(_ urlParameters: Parameters, to userInfo: inout Parameters)
}

// MARK: - Default

public extension ServicesURLNavigate {
    static func register(_ url: NavigationRouterURL, with action: @escaping NavigationAction) {
        NavigationTable.shared.saveIfNotExist(action, to: url)
    }
    
    static func open(
        _ url: NavigationRouterURL,
        with userInfo: Parameters = [:],
        mode: NavigationMode? = nil,
        animated: Bool? = nil,
        completion: VoidClosure? = nil
    ) {
        guard let actionBlock = NavigationTable.shared.value(of: url) else {
            print("❌ No route table found for the given URL! Please check if the URL is registered. url: \(url)")
            return
        }
        
        let urlParameters = url.query
        
        // If the url contains parameters, use special key wrapping to add the parameters to the `userInfo`
        var userInfo = userInfo
        parse(urlParameters, to: &userInfo)
        
        guard let controller = actionBlock(userInfo) as? UIViewController else {
            print("❌ The behavior event should return a `UIViewController` object or its subclass! Please check your code.")
            return
        }
        
        guard let topVisibleViewController = UIApplication.shared.rsv.topVisibleViewController() else {
            print("❌ Failed to retrieve the currently displayed view controller, unable to perform the navigation.")
            return
        }
        
        // If not provided externally, it tries to query from the url parameter and ends up touting the default value.
        let _mode = mode ?? getMode(from: urlParameters) ?? .default
        let _animated = animated ?? getAnimated(from: urlParameters) ?? true
        
        show(
            controller,
            mode: _mode,
            animated: _animated,
            by: topVisibleViewController,
            completion: completion
        )
    }
    
    static func parse(_ urlParameters: Parameters, to userInfo: inout Parameters) {
        guard !urlParameters.isEmpty else { return }
        userInfo[Key.urlParameters] = urlParameters
    }
}

// MARK: - Public Tools

public extension ServicesURLNavigate {
    static func show(
        _ controller: UIViewController,
        mode: NavigationMode,
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

private extension ServicesURLNavigate {
    typealias Key = NavigationPredefinedKey
    
    static func getURLParameters(from userInfo: Parameters) -> Parameters? {
        return userInfo[Key.urlParameters] as? Parameters
    }
    
    static func getMode(from urlParameters: Parameters) -> NavigationMode? {
        let value = urlParameters[Key.modeType] as? NavigationMode.Identifier
        return value.flatMap { NavigationMode(identifier: $0) }
    }
    
    static func getAnimated(from urlParameters: Parameters) -> Bool? {
        let value = urlParameters[Key.animation]
        guard let stringValue = value as? String else { return nil }
        return !{ $0 == "false" || $0 == "0" }(stringValue.lowercased())
    }
}
