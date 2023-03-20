//
//  ServiceURLNavigable.swift
//  RaServices
//
//  Created by Rakuyo on 2023/03/17.
//  Copyright © 2023 Rakuyo. All rights reserved.
//

import Foundation

import RaServicesCore

///
public protocol ServiceURLNavigable {
    ///
    static func createRouterProvider() -> Any
    
    ///
    static func open(with userInfo: Parameters, completion: VoidClosure?)
    
    ///
    static func open(by method: NavigationMethod, userInfo: Parameters, completion: VoidClosure?)
}

// MARK: - Default

public extension ServiceURLNavigable {
    typealias PredefinedKey = ServicePredefinedKey.Navigation
    
    static func open(with userInfo: Parameters, completion: VoidClosure? = nil) {
        guard let methodOfUserInfo = userInfo[PredefinedKey.method] else {
            print("❌ No navigation method is specified, this navigation will be ignored. userInfo: \(userInfo)")
            return
        }
        
        func _open(by method: NavigationMethod?) {
            guard let method = method else {
                print("❌ Invalid navigation method! This navigation will be ignored. userInfo: \(userInfo)")
                return
            }
            open(by: method, userInfo: userInfo, completion: completion)
        }
        
        if let methodType = methodOfUserInfo as? NavigationMethod.MethodType {
            let animation = userInfo[PredefinedKey.animation] as? Bool
            let sender = userInfo[PredefinedKey.sender]
            
            let method = NavigationMethod(methodType: methodType, animated: animation, sender: sender)
            _open(by: method)
            
        } else {
            _open(by: methodOfUserInfo as? NavigationMethod)
        }
    }
    
    static func open(by method: NavigationMethod, userInfo: Parameters = [:], completion: VoidClosure? = nil) {
        let router = routerProviderType.router
        Router.open(router, with: userInfo, method: method, completion: completion)
    }
}

// MARK: -

public extension ServiceURLNavigable {
    ///
    static func registerRouter() {
        let provider = routerProviderType
        Router.register(provider.router, with: provider.factory)
    }
}

public extension ServicePredefinedKey {
    enum Navigation {
        ///
        static let method = "ra_navigation_method"
        
        ///
        static let sender = "ra_navigation_sender"
        
        ///
        static let animation = "ra_navigation_animation"
    }
}

// MARK: - Tools

private extension ServiceURLNavigable {
    static var routerProviderType: ServiceRouterProvider.Type {
        type(of: routerProvider)
    }
    
    static var routerProvider: ServiceRouterProvider {
        guard let routerProvider = createRouterProvider() as? ServiceRouterProvider else {
            fatalError("You need to ensure that the object returned by `createRouterProvider()` is of type `\(ServiceRouterProvider.self)`! Please check your code.")
        }
        return routerProvider
    }
}
