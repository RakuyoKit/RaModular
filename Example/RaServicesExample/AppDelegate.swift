//
//  AppDelegate.swift
//  RaServicesExample
//
//  Created by Rakuyo on 2023/3/20.
//

import UIKit

import RaServicesCore

import OrderInterface

@main
class AppDelegate: ServicesAppDelegate {

    override var services: [Services] {
        [OrderService.self]
    }
    
    override func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        print("subclass applicationDidFinishLaunching")
        
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
}
