//
//  LifecycleProviding.swift
//  RaModular
//
//  Created by Rakuyo on 2023/03/21.
//  Copyright © 2023 Rakuyo. All rights reserved.
//

import Foundation

///
public protocol LifecycleProviding {
    /// A placeholder to mask the real type.
    associatedtype LifecycleProviderMock = AnyObject
    
    ///
    func createLifecycleProvider() -> LifecycleProviderMock
    
    ///
    var weight: String { get }
}

// MARK: - Default

public extension LifecycleProviding {
    var weight: String { "" }
}
