//
//  ServiceProviding.swift
//  RaServices
//
//  Created by Rakuyo on 2023/03/20.
//  Copyright © 2023 Rakuyo. All rights reserved.
//

import Foundation

import RaServicesBehavior
import RaServicesURLNavigate

public protocol ServiceProviding: ServiceBehaviorProviding & ServiceURLNavigable {
    /// Actual provider.
    associatedtype Provider
    
    ///
    associatedtype BehaviorProvider = Provider
    
    ///
    static func createProvider() -> Any
}

// MARK: - ServiceBehaviorProviding Default Provider

public extension ServiceProviding {
    static func createBehaviorProvider() -> Any {
        return createProvider()
    }
}

// MARK: - ServiceURLNavigable Default Provider

public extension ServiceProviding {
    static func createRouterProvider() -> Any {
        return createProvider()
    }
}
