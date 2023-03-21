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
public protocol ServiceProviding: ServiceBehaviorProviding & ServiceNavigationProviding & ServiceLifecycleProviding {
    /// Creating a service provider instance.
    static func createProvider() -> Any?
    
    ///
    static func createProviderObject() -> AnyObject
}

public extension ServiceProviding {
    static func createProvider() -> Any? {
        return nil
    }
    
    static func createProviderObject() -> AnyObject {
        fatalError("❌ As a backing method, you should at least implement the method")
    }
}

// MARK: - ServiceBehaviorProviding Default Provider

public extension ServiceProviding {
    static func createBehaviorProvider() -> Any {
        return createProvider() ?? createProviderObject()
    }
}

// MARK: - ServiceNavigationProviding Default Provider

public extension ServiceProviding {
    static func createNavigationProvider() -> Any {
        return createProvider() ?? createProviderObject()
    }
}

// MARK: - ServiceLifecycleProviding Default Provider

public extension ServiceProviding {
    static func createLifecycleProvider() -> AnyObject {
        return createProviderObject()
    }
}
