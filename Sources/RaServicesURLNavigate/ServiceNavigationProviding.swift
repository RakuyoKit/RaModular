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
    associatedtype NavigationProviderMock = Any
    
    ///
    func createNavigationProvider() -> NavigationProviderMock
    
    ///
    func open(with userInfo: Parameters, mode: NavigationMode?, animated: Bool?, completion: VoidClosure?)
}

// MARK: - Default

public extension ServiceNavigationProviding {
    func open(
        with userInfo: Parameters = [:],
        mode: NavigationMode? = nil,
        animated: Bool? = nil,
        completion: VoidClosure? = nil
    ) {
        let target = routerProvider.getRouterTarget(with: userInfo)
        
        // Enables automatic registration in some scenarios with the help of repeated registration.
        target.registerRouter()
        
        Navigation.open(target.router, with: userInfo, mode: mode, animated: animated, completion: completion)
    }
}

// MARK: - Tools

private extension ServiceNavigationProviding {
    var routerProvider: ServiceNavigationProvider {
        guard let routerProvider = createNavigationProvider() as? ServiceNavigationProvider else {
            fatalError("You need to ensure that the object returned by `createNavigationProvider()` is of type `\(ServiceNavigationProvider.self)`! Please check your code.")
        }
        return routerProvider
    }
}
