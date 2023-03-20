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

/// A collection of ServiceBehaviorProviding and ServiceNavigationProviding that
/// simplifies the process when using both protocols simultaneously.
public protocol ServiceProviding: ServiceBehaviorProviding & ServiceNavigationProviding {
    /// Creating a service provider instance.
    static func createProvider() -> Any
}

// MARK: - ServiceBehaviorProviding Default Provider

public extension ServiceProviding {
    static func createBehaviorProvider() -> Any {
        return createProvider()
    }
}

// MARK: - ServiceNavigationProviding Default Provider

public extension ServiceProviding {
    static func createNavigationProvider() -> Any {
        return createProvider()
    }
}
