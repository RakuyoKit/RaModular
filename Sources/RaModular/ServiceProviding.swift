//
//  ServiceProviding.swift
//  RaModular
//
//  Created by Rakuyo on 2023/03/20.
//  Copyright © 2023 Rakuyo. All rights reserved.
//

import Foundation

import RaModularBehavior
import RaModularRouter

/// Define the features provided by the service.
///
/// You need to define a type in the service interface component that will follow this protocol.
///
/// For example, something like the following:
/// ```
/// import RaModular
///
/// public struct OrderService: ServiceProviding {
///     public typealias BehaviorProvider = OrderServiceBehaviorProvider
///
///     public static let shared = OrderService()
///     private init() { }
///
///     public let weight: String = "a_b"
///
///     public func createProvider() -> AnyObject {
///         return OrderServiceProvider()
///     }
/// }
/// ```
public protocol ServiceProviding: BehaviorProviding & RouterProviding & LifecycleProviding {
    /// A placeholder to mask the real type.
    associatedtype ProviderMock = AnyObject
    
    /// Creating a service provider instance.
    func createProvider() -> ProviderMock
}

// MARK: - BehaviorProviding Default Provider

public extension ServiceProviding {
    typealias BehaviorProviderMock = ProviderMock
    
    func createBehaviorProvider() -> BehaviorProviderMock {
        return createProvider()
    }
}

// MARK: - RouterProviding Default Provider

public extension ServiceProviding {
    typealias RouterProviderMock = ProviderMock
    
    func createRouterProvider() -> RouterProviderMock {
        return createProvider()
    }
}

// MARK: - LifecycleProviding Default Provider

public extension ServiceProviding {
    typealias LifecycleProviderMock = ProviderMock
    
    func createLifecycleProvider() -> LifecycleProviderMock {
        return createProvider()
    }
}
