//
//  AppDelegate.swift
//  RaServicesExample
//
//  Created by Rakuyo on 2023/3/20.
//

import UIKit

import OrderInterface
import RaServicesCore

@main
class AppDelegate: ServicesAppDelegate {

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
