//
//  BehaviorProviding.swift
//  RaModular
//
//  Created by Rakuyo on 2023/03/17.
//  Copyright © 2023 Rakuyo. All rights reserved.
//

import Foundation

import RaModularCore

/// This service is declared to have open functionality and is available for use by other services.
///
/// You need to define a type in the service interface component that will follow this protocol.
///
/// For example, something like the following:
/// ```
/// import RaModular
///
/// public struct OrderService: BehaviorProviding {
///     public typealias BehaviorProvider = OrderServiceProvider
///
///     public static func createBehaviorProvider() -> Any {
///         return OrderServiceProvider()
///     }
/// }
/// ```
public protocol BehaviorProviding {
    /// The real provider of the service.
    /// The type masked by the `BehaviorProviderMock`.
    associatedtype BehaviorProvider
    
    /// A placeholder to mask the real type.
    associatedtype BehaviorProviderMock = Any
    
    /// Used for creating a behavior provider.
    ///
    /// You should implement this method in the interface module of your service,
    /// returning an instance object that matches the `BehaviorProvider` type in your service module.
    ///
    /// NOTE: The service caller should not manually call this method.
    /// Please use the `behaviorProvider` property below to obtain the instance of the behavior provider.
    func createBehaviorProvider() -> BehaviorProviderMock
    
    /// Convert the object created by `createBehaviorProvider()` to the `BehaviorProvider` type and return it.
    ///
    /// This method is intended for the callers of the service.
    /// You can use this method to obtain the behavior provider,
    /// which can then be used to trigger specific behaviors.
    var behaviorProvider: BehaviorProvider { get }
}

// MARK: - Default

public extension BehaviorProviding {
    var behaviorProvider: BehaviorProvider {
        guard let provider = createBehaviorProvider() as? BehaviorProvider else {
            fatalError("You need to ensure that the object returned by `createBehaviorProvider()` is of type `\(BehaviorProvider.self)`! Please check your code.")
        }
        return provider
    }
}
