//
//  ServicesURLNavigate.swift
//  RaServices
//
//  Created by Rakuyo on 2023/03/17.
//  Copyright © 2023 Rakuyo. All rights reserved.
//

import Foundation

import RaServicesCore

public protocol ServicesURLNavigate {
    ///
    static func register(_ url: NavigationRouterURL, with action: @escaping NavigationAction)
    
    ///
    static func open(_ url: NavigationRouterURL, with userInfo: Parameters, mode: NavigationMode?, animated: Bool?, completion: VoidClosure?)
}

// MARK: - Default

public extension ServicesURLNavigate {
    static func register(_ url: NavigationRouterURL, with action: @escaping NavigationAction) {
        NavigationTable.shared.save(action, to: url)
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
        
        // Extracting the parameters from the URL and putting them into the `userInfo` dictionary.
        var userInfo = userInfo
        for query in url.query {
            // Add `url_` prefix to avoid conflict with original parameters
            //
            // This implementation is temporary, and the prefix may be removed in the future.
            // Depends on the feedback after the release.
            userInfo["url_\(query.name)"] = query.value
        }
        
        guard let controller = actionBlock(userInfo) as? UIViewController else {
            print("❌ The behavior event should return a `UIViewController` object or its subclass! Please check your code.")
            return
        }
        
        guard let topVisibleViewController = UIApplication.shared.ras.topVisibleViewController() else {
            print("❌ Failed to retrieve the currently displayed view controller, unable to perform the navigation.")
            return
        }
        
        func getMode() -> NavigationMode? {
            let value = userInfo[PredefinedKey.Navigation.modeType] as? NavigationMode.Identifier
            return value.flatMap { NavigationMode(identifier: $0, sender: userInfo[PredefinedKey.Navigation.sender]) }
        }
        let _mode = mode ?? getMode() ?? .default
        
        func getAnimated() -> Bool? {
            let value = userInfo[PredefinedKey.Navigation.animation]
            return value as? Bool
        }
        let _animated = animated ?? getAnimated() ?? true
        
        func _setCompletion() {
            setCompletion(completion, with: topVisibleViewController.transitionCoordinator, animated: _animated)
        }
        
        func _navigate(action: VoidClosure) {
            if _animated {
                action()
            } else {
                UIView.performWithoutAnimation(action)
            }
            _setCompletion()
        }
        
        switch _mode {
        case .show(let sender):
            _navigate {
                topVisibleViewController.show(controller, sender: sender)
            }
            
        case .showDetail(let sender):
            _navigate {
                topVisibleViewController.showDetailViewController(controller, sender: sender)
            }
            
        case .push:
            topVisibleViewController.navigationController?.pushViewController(controller, animated: _animated)
            _setCompletion()
            
        case .present:
            topVisibleViewController.present(controller, animated: _animated, completion: completion)
        }
    }
}

public extension PredefinedKey {
    enum Navigation {
        ///
        static let modeType = "ra_navigation_mode_type"
        
        ///
        static let sender = "ra_navigation_sender"
        
        ///
        static let animation = "ra_navigation_animation"
    }
}

// MARK: - Private

private extension ServicesURLNavigate {
    static func setCompletion(
        _ completion: VoidClosure?,
        with transitionCoordinator: UIViewControllerTransitionCoordinator?,
        animated: Bool
    ) {
        guard animated, let coordinator = transitionCoordinator else {
            DispatchQueue.main.async { completion?() }
            return
        }
        coordinator.animate(alongsideTransition: nil) { _ in completion?() }
    }
}
