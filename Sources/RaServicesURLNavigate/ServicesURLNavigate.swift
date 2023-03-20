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
    static func open(_ url: NavigationRouterURL, with userInfo: Parameters, method: NavigationMethod, completion: VoidClosure?)
}

// MARK: - Default

public extension ServicesURLNavigate {
    static func register(_ url: NavigationRouterURL, with action: @escaping NavigationAction) {
        NavigationFactory.shared.cache(action, to: url)
    }
    
    static func open(
        _ url: NavigationRouterURL,
        with userInfo: Parameters,
        method: NavigationMethod,
        completion: VoidClosure?
    ) {
        guard let actionBlock = NavigationFactory.shared.value(of: url) else {
            print("❌ No corresponding factory found.")
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
            print("❌ Requesting the show factory to return a subclass of UIViewController")
            return
        }
        
        guard let topVisibleViewController = UIApplication.shared.ras.topVisibleViewController() else {
            print("❌ Failed to retrieve the currently displayed view controller, unable to perform the navigation.")
            return
        }
        
        func _setCompletion() {
            setCompletion(completion, with: topVisibleViewController.transitionCoordinator)
        }
        
        switch method {
        case .show(let sender):
            topVisibleViewController.show(controller, sender: sender)
            _setCompletion()
            
        case .showDetail(let sender):
            topVisibleViewController.showDetailViewController(controller, sender: sender)
            _setCompletion()
            
        case .push(let animated):
            topVisibleViewController.navigationController?.pushViewController(controller, animated: animated)
            _setCompletion()
            
        case .present(let animated):
            topVisibleViewController.present(controller, animated: animated, completion: completion)
        }
    }
}

// MARK: - Private

private extension ServicesURLNavigate {
    static func setCompletion(
        _ completion: VoidClosure?,
        with transitionCoordinator: UIViewControllerTransitionCoordinator?
    ) {
        guard let coordinator = transitionCoordinator else {
            DispatchQueue.main.async { completion?() }
            return
        }
        coordinator.animate(alongsideTransition: nil) { _ in completion?() }
    }
}