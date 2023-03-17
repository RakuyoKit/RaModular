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
public protocol ServiceBehaviorProviding {
    /// Actual provider of the behavior.
    associatedtype BehaviorProvider
    
    ///
    static func createBehaviorProvider() -> Any
    
    ///
    static var behaviorProvider: BehaviorProvider { get }
}

// MARK: - Default

public extension ServiceBehaviorProviding {
    static var behaviorProvider: BehaviorProvider {
        guard let provider = createBehaviorProvider() as? BehaviorProvider else {
            fatalError("You need to ensure that the object returned by `createBehaviorProvider(with:)` is of type `\(BehaviorProvider.self)`! Please check your code.")
        }
        return provider
    }
}
