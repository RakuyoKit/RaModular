//
//  ServicesSceneDelegate.swift
//  RaServicesCore
//
//  Created by Rakuyo on 2023/3/21.
//  Copyright © 2023 Rakuyo. All rights reserved.
//

import UIKit

///
@available(iOS 13.0, *)
open class ServicesSceneDelegate: BaseLifecycleDelegate {
    ///
    private lazy var delegateServices = {
        ContiguousArray(internalCachedServices.compactMap { $0 as? UIWindowSceneDelegate })
    }()
}

// MARK: - UIWindowSceneDelegate

@available(iOS 13.0, *)
extension ServicesSceneDelegate: UIWindowSceneDelegate {
    open func windowScene(
        _ windowScene: UIWindowScene,
        didUpdate previousCoordinateSpace: UICoordinateSpace,
        interfaceOrientation previousInterfaceOrientation: UIInterfaceOrientation,
        traitCollection previousTraitCollection: UITraitCollection
    ) {
        delegateServices.rsv.distribute {
            $0.windowScene?(windowScene, didUpdate: previousCoordinateSpace, interfaceOrientation: previousInterfaceOrientation, traitCollection: previousTraitCollection)
        }
    }
    
    open func windowScene(
        _ windowScene: UIWindowScene,
        performActionFor shortcutItem: UIApplicationShortcutItem,
        completionHandler: @escaping (Bool) -> Void
    ) {
        delegateServices.rsv.distribute {
            $0.windowScene?(windowScene, performActionFor: shortcutItem, completionHandler: $1)
        } completion: {
            let result = $0.reduce(true) { $0 && $1 }
            completionHandler(result)
        }
    }
}

// MARK: - UISceneDelegate

@available(iOS 13.0, *)
extension ServicesSceneDelegate: UISceneDelegate {
    open func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        delegateServices.rsv.distribute {
            $0.scene?(scene, willConnectTo: session, options: connectionOptions)
        }
    }
    
    open func sceneDidDisconnect(_ scene: UIScene) {
        delegateServices.rsv.distribute {
            $0.sceneDidDisconnect?(scene)
        }
    }
    
    open func sceneDidBecomeActive(_ scene: UIScene) {
        delegateServices.rsv.distribute {
            $0.sceneDidBecomeActive?(scene)
        }
    }
    
    open func sceneWillResignActive(_ scene: UIScene) {
        delegateServices.rsv.distribute {
            $0.sceneWillResignActive?(scene)
        }
    }
    
    open func sceneWillEnterForeground(_ scene: UIScene) {
        delegateServices.rsv.distribute {
            $0.sceneWillEnterForeground?(scene)
        }
    }
    
    open func sceneDidEnterBackground(_ scene: UIScene) {
        delegateServices.rsv.distribute {
            $0.sceneDidEnterBackground?(scene)
        }
    }
    
    open func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        delegateServices.rsv.distribute {
            $0.scene?(scene, openURLContexts: URLContexts)
        }
    }
    
    open func stateRestorationActivity(for scene: UIScene) -> NSUserActivity? {
        delegateServices.rsv.distribute {
            $0.stateRestorationActivity?(for: scene)
        }.first
    }
    
    open func scene(_ scene: UIScene, restoreInteractionStateWith stateRestorationActivity: NSUserActivity) {
        delegateServices.rsv.distribute {
            $0.scene?(scene, restoreInteractionStateWith: stateRestorationActivity)
        }
    }
    
    open func scene(_ scene: UIScene, willContinueUserActivityWithType userActivityType: String) {
        delegateServices.rsv.distribute {
            $0.scene?(scene, willContinueUserActivityWithType: userActivityType)
        }
    }
    
    open func scene(_ scene: UIScene, continue userActivity: NSUserActivity) {
        delegateServices.rsv.distribute {
            $0.scene?(scene, continue: userActivity)
        }
    }
    
    open func scene(_ scene: UIScene, didFailToContinueUserActivityWithType userActivityType: String, error: Error) {
        delegateServices.rsv.distribute {
            $0.scene?(scene, didFailToContinueUserActivityWithType: userActivityType, error: error)
        }
    }
    
    open func scene(_ scene: UIScene, didUpdate userActivity: NSUserActivity) {
        delegateServices.rsv.distribute {
            $0.scene?(scene, didUpdate: userActivity)
        }
    }
}
