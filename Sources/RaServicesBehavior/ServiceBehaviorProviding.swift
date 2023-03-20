//
//  ServiceEntrance.swift
//  RaServices
//
//  Created by Rakuyo on 2023/03/17.
//  Copyright © 2023 Rakuyo. All rights reserved.
//

import Foundation

import RaServicesCore

/// Declare that the service contains behaviors available for external invocation.
///
/// Let's take a concrete example to see how to use this protocol.
///
/// ```swift
/// import RaServices
///
/// public struct OrderService: ServiceBehaviorProviding {
///     public typealias BehaviorProvider = OrderServiceBehaviorProvider
///
///     public static func createBehaviorProvider() -> Any {
///         return OrderServiceProvider()
///     }
/// }
/// ```
public protocol ServiceBehaviorProviding {
    /// Actual provider of the behavior.
    associatedtype BehaviorProvider
    
    /// Used for creating a behavior provider.
    ///
    /// You should implement this method in the interface module of your service/component,
    /// returning an instance object that matches the `BehaviorProvider` type in your service/component module.
    ///
    /// NOTE: The service/component caller should not manually call this method.
    /// Please use the behaviorProvider property below to obtain the instance of the behavior provider.
    static func createBehaviorProvider() -> Any
    
    /// Convert the object created by `createBehaviorProvider()` to the BehaviorProvider type and return it.
    ///
    /// This method is intended for the callers of the service/component.
    /// Users can use this method to obtain the behavior provider, which can then be used to trigger specific behaviors.
    static var behaviorProvider: BehaviorProvider { get }
}

// MARK: - Default

public extension ServiceBehaviorProviding {
    static var behaviorProvider: BehaviorProvider {
        guard let provider = createBehaviorProvider() as? BehaviorProvider else {
            fatalError("You need to ensure that the object returned by `createBehaviorProvider()` is of type `\(BehaviorProvider.self)`! Please check your code.")
        }
        return provider
    }
}
