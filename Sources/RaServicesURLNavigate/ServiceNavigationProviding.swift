//
//  ServiceNavigationProviding.swift
//  RaServices
//
//  Created by Rakuyo on 2023/03/17.
//  Copyright © 2023 Rakuyo. All rights reserved.
//

import Foundation

import RaServicesCore

///
public protocol ServiceNavigationProviding {
    typealias Method = NavigationMethod
    
    ///
    static func createNavigationProvider() -> Any
    
    ///
    static func open(with userInfo: Parameters, completion: VoidClosure?)
    
    ///
    static func open(by method: Method, userInfo: Parameters, completion: VoidClosure?)
}

// MARK: - Default

public extension ServiceNavigationProviding {
    typealias PredefinedKey = ServicePredefinedKey.Navigation
    
    static func open(with userInfo: Parameters, completion: VoidClosure? = nil) {
        guard let methodOfUserInfo = userInfo[PredefinedKey.method] else {
            print("❌ No navigation method is specified, this navigation will be ignored. userInfo: \(userInfo)")
            return
        }
        
        func _open(by method: Method?) {
            guard let method = method else {
                print("❌ Invalid navigation method! This navigation will be ignored. userInfo: \(userInfo)")
                return
            }
            open(by: method, userInfo: userInfo, completion: completion)
        }
        
        if let methodType = methodOfUserInfo as? Method.MethodType {
            let animation = userInfo[PredefinedKey.animation] as? Bool
            let sender = userInfo[PredefinedKey.sender]
            
            let method = Method(methodType: methodType, animated: animation, sender: sender)
            _open(by: method)
            
        } else {
            _open(by: methodOfUserInfo as? Method)
        }
    }
    
    static func open(by method: Method, userInfo: Parameters = [:], completion: VoidClosure? = nil) {
        let url = routerProviderType.router
        Navigation.open(url, with: userInfo, method: method, completion: completion)
    }
}

// MARK: -

public extension ServiceNavigationProviding {
    ///
    static func register() {
        let provider = routerProviderType
        Navigation.register(provider.router, with: provider.action)
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

private extension ServiceNavigationProviding {
    static var routerProviderType: ServiceNavigationProvider.Type {
        type(of: routerProvider)
    }
    
    static var routerProvider: ServiceNavigationProvider {
        guard let routerProvider = createNavigationProvider() as? ServiceNavigationProvider else {
            fatalError("You need to ensure that the object returned by `createNavigationProvider()` is of type `\(ServiceNavigationProvider.self)`! Please check your code.")
        }
        return routerProvider
    }
}
