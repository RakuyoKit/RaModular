//
//  BaseLifecycleDelegate.swift
//  RaServicesCore
//
//  Created by Rakuyo on 2023/03/23.
//  Copyright © 2023 Rakuyo. All rights reserved.
//

import UIKit

/// Base Classes for Life Cycle Delegate.
open class BaseLifecycleDelegate<Delegate>: UIResponder {
    public typealias Services = ServiceLifecycleProviding
    
    /// Types of modules requiring lifecycle interfaces
    open var services: [any Services] {
        fatalError("❌ Subclasses must override this method! Otherwise you may need to inherit from this class as well.")
    }
    
    /// Object internal cache of `services`.
    ///
    /// Avoid the need to get the corresponding type array by calculating properties
    /// every time the lifecycle method is triggered.
    private lazy var internalCachedServices = {
        ContiguousArray(services
            .compactMap { $0.createLifecycleProvider() })
    }()
    
    /// Get all the data from `internalCachedServices` that can be converted to the `Delegate` type.
    lazy var delegateServices = {
        ContiguousArray(internalCachedServices.compactMap { $0 as? Delegate })
    }()
}
