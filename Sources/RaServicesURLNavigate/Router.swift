//
//  Router.swift
//  RaServices
//
//  Created by Rakuyo on 2023/03/17.
//  Copyright © 2023 Rakuyo. All rights reserved.
//

import UIKit

import RaServicesCore

///
public enum Router {
    
    public typealias Factory = RouterMapFactory.Factory
    
    static func register(_ router: ServiceRouter, with factory: @escaping Factory) {
        RouterMapFactory.shared.cache(router: router, with: factory)
    }
    
    static func open(
        _ router: ServiceRouter,
        with userInfo: Parameters,
        method: NavigationMethod,
        completion: VoidClosure?
    ) {
        guard let factory = RouterMapFactory.shared.factory(of: router) else {
            print("❌ No corresponding factory found.")
            return
        }
        
        // Extracting the parameters from the URL and putting them into the `userInfo` dictionary.
        var userInfo = userInfo
        for query in router.query {
            // Add `url_` prefix to avoid conflict with original parameters
            //
            // This implementation is temporary, and the prefix may be removed in the future.
            // Depends on the feedback after the release.
            userInfo["url_\(query.name)"] = query.value
        }
        
        guard let controller = factory(userInfo) as? UIViewController else {
            print("❌ Requesting the show factory to return a subclass of UIViewController")
            return
        }
        
        guard let topVisibleViewController = UIApplication.shared.ras.topVisibleViewController() else {
            print("❌ Failed to retrieve the currently displayed view controller, unable to perform the navigation.")
            return
        }
        
        switch method {
        case .show(let sender):
            navigate(withCompletion: completion) {
                topVisibleViewController.show(controller, sender: sender)
            }
            
        case .showDetail(let sender):
            navigate(withCompletion: completion) {
                topVisibleViewController.showDetailViewController(controller, sender: sender)
            }
            
        case .push(let animated):
            navigate(withCompletion: completion) {
                topVisibleViewController.navigationController?.pushViewController(controller, animated: animated)
            }
            
        case .present(let animated):
            topVisibleViewController.present(controller, animated: animated, completion: completion)
        }
    }
}

private extension Router {
    static func navigate(withCompletion completion: VoidClosure?, action: VoidClosure) {
        CATransaction.setCompletionBlock(completion)
        CATransaction.begin()
        action()
        CATransaction.commit()
    }
}
