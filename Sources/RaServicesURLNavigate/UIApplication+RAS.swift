//
//  UIApplication+RAS.swift
//  RaServices
//
//  Created by Rakuyo on 2023/03/17.
//  Copyright © 2023 Rakuyo. All rights reserved.
//

import UIKit

import RaServicesCore

extension RASExtendable where Base: UIApplication {
    /// return the `keyWindow`.
    var keyWindow: UIWindow? {
        if #available(iOS 13.0, *) {
            return mainScene?.windows.first { $0.isKeyWindow }
        } else {
            return Base.shared.keyWindow
        }
    }
    
    /// Get the root view controller.
    var rootViewController: UIViewController? { keyWindow?.rootViewController }
    
    /// The currently displayed topmost view controller.
    func topVisibleViewController(
        base: UIViewController? = Base.shared.ras.rootViewController
    ) -> UIViewController? {
        guard base != nil else { return nil }
        
        if let nav = base as? UINavigationController {
            return topVisibleViewController(base: nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            return topVisibleViewController(base: tab.selectedViewController)
        }
        if let presented = base?.presentedViewController {
            return topVisibleViewController(base: presented)
        }
        if let split = base as? UISplitViewController {
            return topVisibleViewController(base: split.presentingViewController)
        }
        return base
    }
}

// MARK: - Tools

extension RASExtendable where Base: UIApplication {
    /// Used to replace `UIScreen.main`.
    @available(iOS 13.0, *)
    var mainScene: UIWindowScene? {
        base.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .first
    }
}
