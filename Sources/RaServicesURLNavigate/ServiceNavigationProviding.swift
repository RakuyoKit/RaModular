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
    ///
    static func createNavigationProvider() -> Any
    
    ///
    static func open(with userInfo: Parameters, mode: NavigationMode?, animated: Bool?, completion: VoidClosure?)
}

// MARK: - Default

public extension ServiceNavigationProviding {
    static func open(
        with userInfo: Parameters = [:],
        mode: NavigationMode? = nil,
        animated: Bool? = nil,
        completion: VoidClosure? = nil
    ) {
        let target = routerProviderType.getRouterTarget(with: userInfo)
        Navigation.open(target.router, with: userInfo, mode: mode, animated: animated, completion: completion)
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
