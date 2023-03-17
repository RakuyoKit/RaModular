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

public extension ServiceURLNavigable {
    static func registerRouter() {
        let provider = routerProviderType
        Router.register(provider.router, with: provider.factory)
    }
}

// MARK: - Default

extension ServiceURLNavigable {
    public static func open(with userInfo: Parameters, completion: VoidClosure?) {
        #warning("TODO Get the `NavigationMethod` object from the `userInfo` dictionary, and then call the `open(by:, userInfo:, completion:)` method.")
    }
    
    public static func open(by method: NavigationMethod, userInfo: Parameters = [:], completion: VoidClosure? = nil) {
        let router = routerProviderType.router
        
        #warning("TODO Here, the parameters that may exist in the URL should be extracted and stored in the `userInfo` dictionary.")
        
        Router.open(router, with: userInfo, method: method, completion: completion)
    }
    
    private static var routerProviderType: ServiceRouterProvider.Type {
        type(of: routerProvider)
    }
    
    private static var routerProvider: ServiceRouterProvider {
        guard let routerProvider = createRouterProvider() as? ServiceRouterProvider else {
            fatalError("You need to ensure that the object returned by `createRouterProvider()` is of type `\(ServiceRouterProvider.self)`! Please check your code.")
        }
        return routerProvider
    }
}
