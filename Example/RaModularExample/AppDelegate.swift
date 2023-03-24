//
//  AppDelegate.swift
//  RaModularExample
//
//  Created by Rakuyo on 2023/03/20.
//

import UIKit

import OrderInterface
import RaModularCore

@main
class AppDelegate: ModularAppDelegate {

    override var services: [any Services] {
        [
            OrderService.shared,
        ]
    }
    
    override func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        print("subclass applicationDidFinishLaunching")
        
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
}
