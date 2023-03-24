//
//  ModularSceneDelegate.swift
//  RaModular
//
//  Created by Rakuyo on 2023/03/21.
//  Copyright © 2023 Rakuyo. All rights reserved.
//

import UIKit

/// Replaces the `SceneDelegate` class in the main project and
/// is responsible for distributing lifecycle events to submodules.
///
/// Please note:
/// This class does not distribute all the `UIWindowSceneDelegate` methods.
/// For the methods that are not implemented, you can try to implement the corresponding methods in the main project
/// and then refer to the implementation in this document to distribute the events to the submodules.
///
/// You should modify the `SceneDelegate` implementation in your main project to change its parent class to this type.
/// 
/// Example:
/// ```
/// import RaModular
///
/// class SceneDelegate: ModularSceneDelegate {
///     // your code ...
/// }
/// ```
@available(iOS 13.0, *)
open class ModularSceneDelegate: BaseLifecycleDelegate<UIWindowSceneDelegate>, UIWindowSceneDelegate {
    open func windowScene(
        _ windowScene: UIWindowScene,
        didUpdate previousCoordinateSpace: UICoordinateSpace,
        interfaceOrientation previousInterfaceOrientation: UIInterfaceOrientation,
        traitCollection previousTraitCollection: UITraitCollection
    ) {
        delegateServices.rmd.distribute {
            $0.windowScene?(windowScene, didUpdate: previousCoordinateSpace, interfaceOrientation: previousInterfaceOrientation, traitCollection: previousTraitCollection)
        }
    }
    
    open func windowScene(
        _ windowScene: UIWindowScene,
        performActionFor shortcutItem: UIApplicationShortcutItem,
        completionHandler: @escaping (Bool) -> Void
    ) {
        delegateServices.rmd.distribute {
            $0.windowScene?(windowScene, performActionFor: shortcutItem, completionHandler: $1)
        } completion: {
            let result = $0.reduce(true) { $0 && $1 }
            completionHandler(result)
        }
    }
    
    open func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        delegateServices.rmd.distribute {
            $0.scene?(scene, willConnectTo: session, options: connectionOptions)
        }
    }
    
    open func sceneDidDisconnect(_ scene: UIScene) {
        delegateServices.rmd.distribute {
            $0.sceneDidDisconnect?(scene)
        }
    }
    
    open func sceneDidBecomeActive(_ scene: UIScene) {
        delegateServices.rmd.distribute {
            $0.sceneDidBecomeActive?(scene)
        }
    }
    
    open func sceneWillResignActive(_ scene: UIScene) {
        delegateServices.rmd.distribute {
            $0.sceneWillResignActive?(scene)
        }
    }
    
    open func sceneWillEnterForeground(_ scene: UIScene) {
        delegateServices.rmd.distribute {
            $0.sceneWillEnterForeground?(scene)
        }
    }
    
    open func sceneDidEnterBackground(_ scene: UIScene) {
        delegateServices.rmd.distribute {
            $0.sceneDidEnterBackground?(scene)
        }
    }
    
    open func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        delegateServices.rmd.distribute {
            $0.scene?(scene, openURLContexts: URLContexts)
        }
    }
    
    open func stateRestorationActivity(for scene: UIScene) -> NSUserActivity? {
        delegateServices.rmd.distribute {
            $0.stateRestorationActivity?(for: scene)
        }.first
    }
    
    open func scene(_ scene: UIScene, restoreInteractionStateWith stateRestorationActivity: NSUserActivity) {
        delegateServices.rmd.distribute {
            $0.scene?(scene, restoreInteractionStateWith: stateRestorationActivity)
        }
    }
    
    open func scene(_ scene: UIScene, willContinueUserActivityWithType userActivityType: String) {
        delegateServices.rmd.distribute {
            $0.scene?(scene, willContinueUserActivityWithType: userActivityType)
        }
    }
    
    open func scene(_ scene: UIScene, continue userActivity: NSUserActivity) {
        delegateServices.rmd.distribute {
            $0.scene?(scene, continue: userActivity)
        }
    }
    
    open func scene(_ scene: UIScene, didFailToContinueUserActivityWithType userActivityType: String, error: Error) {
        delegateServices.rmd.distribute {
            $0.scene?(scene, didFailToContinueUserActivityWithType: userActivityType, error: error)
        }
    }
    
    open func scene(_ scene: UIScene, didUpdate userActivity: NSUserActivity) {
        delegateServices.rmd.distribute {
            $0.scene?(scene, didUpdate: userActivity)
        }
    }
}
