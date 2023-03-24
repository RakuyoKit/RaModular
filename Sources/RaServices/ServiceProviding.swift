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
    /// A placeholder to mask the real type.
    associatedtype ProviderMock = AnyObject
    
    /// Creating a service provider instance.
    func createProvider() -> ProviderMock
}

// MARK: - ServiceBehaviorProviding Default Provider

public extension ServiceProviding {
    typealias BehaviorProviderMock = ProviderMock
    
    func createBehaviorProvider() -> BehaviorProviderMock {
        return createProvider()
    }
}

// MARK: - ServiceNavigationProviding Default Provider

public extension ServiceProviding {
    typealias NavigationProviderMock = ProviderMock
    
    func createNavigationProvider() -> NavigationProviderMock {
        return createProvider()
    }
}

// MARK: - ServiceLifecycleProviding Default Provider

public extension ServiceProviding {
    typealias LifecycleProviderMock = ProviderMock
    
    func createLifecycleProvider() -> LifecycleProviderMock {
        return createProvider()
    }
}
