//
//  ServiceLifecycleProviding.swift
//  RaServicesCore
//
//  Created by Rakuyo on 2023/3/21.
//  Copyright © 2023 Rakuyo. All rights reserved.
//

import Foundation

///
public protocol ServiceLifecycleProviding {
    associatedtype LifecycleProviderMock = AnyObject
    
    ///
    func createLifecycleProvider() -> LifecycleProviderMock
}
