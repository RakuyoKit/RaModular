//
//  ServicesAppDelegate.swift
//  RaServicesCore
//
//  Created by Rakuyo on 2023/3/21.
//  Copyright © 2023 Rakuyo. All rights reserved.
//

import UIKit

/// Replaces the `AppDelegate` class in the main project and
/// is responsible for distributing lifecycle events to submodules.
///
/// Please note:
/// This class does not distribute all the `UIApplicationDelegate` methods.
/// For the methods that are not implemented, you can try to implement the corresponding methods in the main project
/// and then refer to the implementation in this document to distribute the events to the submodules.
///
/// You should modify the `AppDelegate` implementation in your main project to change its parent class to this type.
/// Example:
///
/// ```swift
/// import RaServicesCore
///
/// class AppDelegate: ServicesAppDelegate {
///     // your code ...
/// }
/// ```
open class ServicesAppDelegate: BaseLifecycleDelegate<UIApplicationDelegate>, UIApplicationDelegate {
    open func application(
        _ application: UIApplication,
        willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
    ) -> Bool {
        return delegateServices.rsv.distribute {
            $0.application?(application, willFinishLaunchingWithOptions: launchOptions)
        }
    }
    
    open func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
    ) -> Bool {
        return delegateServices.rsv.distribute {
            $0.application?(application, didFinishLaunchingWithOptions: launchOptions)
        }
    }
    
    open func applicationDidFinishLaunching(_ application: UIApplication) {
        delegateServices.rsv.distribute {
            $0.applicationDidFinishLaunching?(application)
        }
    }
    
    open func applicationDidBecomeActive(_ application: UIApplication) {
        delegateServices.rsv.distribute {
            $0.applicationDidBecomeActive?(application)
        }
    }
    
    open func applicationWillResignActive(_ application: UIApplication) {
        delegateServices.rsv.distribute {
            $0.applicationWillResignActive?(application)
        }
    }
    
    open func applicationDidEnterBackground(_ application: UIApplication) {
        delegateServices.rsv.distribute {
            $0.applicationDidEnterBackground?(application)
        }
    }
    
    open func applicationWillEnterForeground(_ application: UIApplication) {
        delegateServices.rsv.distribute {
            $0.applicationWillEnterForeground?(application)
        }
    }
    
    open func applicationWillTerminate(_ application: UIApplication) {
        delegateServices.rsv.distribute {
            $0.applicationWillTerminate?(application)
        }
    }
    
    open func applicationProtectedDataWillBecomeUnavailable(_ application: UIApplication) {
        delegateServices.rsv.distribute {
            $0.applicationProtectedDataWillBecomeUnavailable?(application)
        }
    }
    
    open func applicationProtectedDataDidBecomeAvailable(_ application: UIApplication) {
        delegateServices.rsv.distribute {
            $0.applicationProtectedDataDidBecomeAvailable?(application)
        }
    }
    
    open func applicationDidReceiveMemoryWarning(_ application: UIApplication) {
        delegateServices.rsv.distribute {
            $0.applicationDidReceiveMemoryWarning?(application)
        }
    }
    
    open func applicationSignificantTimeChange(_ application: UIApplication) {
        delegateServices.rsv.distribute {
            $0.applicationSignificantTimeChange?(application)
        }
    }
    
    @available(iOS, introduced: 6.0, deprecated: 13.2, message: "Use application:shouldSaveSecureApplicationState: instead")
    open func application(_ application: UIApplication, shouldSaveApplicationState coder: NSCoder) -> Bool {
        return delegateServices.rsv.distribute {
            $0.application?(application, shouldSaveApplicationState: coder)
        }
    }
    
    @available(iOS 13.2, *)
    open func application(_ application: UIApplication, shouldSaveSecureApplicationState coder: NSCoder) -> Bool {
        return delegateServices.rsv.distribute {
            $0.application?(application, shouldSaveSecureApplicationState: coder)
        }
    }
    
    @available(iOS, introduced: 6.0, deprecated: 13.2, message: "Use application:shouldRestoreSecureApplicationState: instead")
    open func application(_ application: UIApplication, shouldRestoreApplicationState coder: NSCoder) -> Bool {
        return delegateServices.rsv.distribute {
            $0.application?(application, shouldRestoreApplicationState: coder)
        }
    }
    
    @available(iOS 13.2, *)
    open func application(_ application: UIApplication, shouldRestoreSecureApplicationState coder: NSCoder) -> Bool {
        return delegateServices.rsv.distribute {
            $0.application?(application, shouldRestoreSecureApplicationState: coder)
        }
    }
    
    open func application(
        _ application: UIApplication,
        viewControllerWithRestorationIdentifierPath identifierComponents: [String],
        coder: NSCoder
    ) -> UIViewController? {
        for services in delegateServices {
            if let controller = services.application?(
                application,
                viewControllerWithRestorationIdentifierPath: identifierComponents,
                coder: coder
            ) {
                return controller
            }
        }
        return nil
    }
    
    open func application(_ application: UIApplication, willEncodeRestorableStateWith coder: NSCoder) {
        delegateServices.rsv.distribute {
            $0.application?(application, willEncodeRestorableStateWith: coder)
        }
    }
    
    open func application(_ application: UIApplication, didDecodeRestorableStateWith coder: NSCoder) {
        delegateServices.rsv.distribute {
            $0.application?(application, didDecodeRestorableStateWith: coder)
        }
    }
    
    open func application(
        _ application: UIApplication,
        willContinueUserActivityWithType userActivityType: String
    ) -> Bool {
        return delegateServices.rsv.distribute {
            $0.application?(application, willContinueUserActivityWithType: userActivityType)
        }
    }
    
    open func application(
        _ application: UIApplication,
        continue userActivity: NSUserActivity,
        restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void
    ) -> Bool {
        let returns = delegateServices.rsv.distribute {
            $0.application?(application, continue: userActivity, restorationHandler: $1)
            
        } completion: {
            let result = $0.reduce([]) { $0 + ($1 ?? []) }
            restorationHandler(result)
        }
        
        return returns.reduce(true) { $0 && $1 }
    }
    
    open func application(_ application: UIApplication, didUpdate userActivity: NSUserActivity) {
        delegateServices.rsv.distribute {
            $0.application?(application, didUpdate: userActivity)
        }
    }
    
    open func application(
        _ application: UIApplication,
        didFailToContinueUserActivityWithType userActivityType: String,
        error: Error
    ) {
        delegateServices.rsv.distribute {
            $0.application?(application, didFailToContinueUserActivityWithType: userActivityType, error: error)
        }
    }
    
    open func application(
        _ application: UIApplication,
        shouldAllowExtensionPointIdentifier extensionPointIdentifier: UIApplication.ExtensionPointIdentifier
    ) -> Bool {
        return delegateServices.rsv.distribute {
            $0.application?(application, shouldAllowExtensionPointIdentifier: extensionPointIdentifier)
        }
    }
    
    open func application(
        _ application: UIApplication,
        willChangeStatusBarOrientation newStatusBarOrientation: UIInterfaceOrientation,
        duration: TimeInterval
    ) {
        delegateServices.rsv.distribute {
            $0.application?(application, willChangeStatusBarOrientation: newStatusBarOrientation, duration: duration)
        }
    }
    
    open func application(
        _ application: UIApplication,
        didChangeStatusBarOrientation oldStatusBarOrientation: UIInterfaceOrientation
    ) {
        delegateServices.rsv.distribute {
            $0.application?(application, didChangeStatusBarOrientation: oldStatusBarOrientation)
        }
    }
    
    open func application(_ application: UIApplication, willChangeStatusBarFrame newStatusBarFrame: CGRect) {
        delegateServices.rsv.distribute {
            $0.application?(application, willChangeStatusBarFrame: newStatusBarFrame)
        }
    }
    
    open func application(_ application: UIApplication, didChangeStatusBarFrame oldStatusBarFrame: CGRect) {
        delegateServices.rsv.distribute {
            $0.application?(application, didChangeStatusBarFrame: oldStatusBarFrame)
        }
    }
    
    open func application(
        _ application: UIApplication,
        didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data
    ) {
        delegateServices.rsv.distribute {
            $0.application?(application, didRegisterForRemoteNotificationsWithDeviceToken: deviceToken)
        }
    }
    
    open func application(
        _ application: UIApplication,
        didFailToRegisterForRemoteNotificationsWithError error: Error
    ) {
        delegateServices.rsv.distribute {
            $0.application?(application, didFailToRegisterForRemoteNotificationsWithError: error)
        }
    }
    
    open func application(
        _ application: UIApplication,
        open url: URL,
        options: [UIApplication.OpenURLOptionsKey: Any] = [:]
    ) -> Bool {
        return delegateServices.rsv.distribute {
            $0.application?(application, open: url, options: options)
        }
    }
}
