//
//  ServiceNavigationProvider.swift
//  RaServices
//
//  Created by Rakuyo on 2023/03/17.
//  Copyright © 2023 Rakuyo. All rights reserved.
//

import Foundation

/// The protocol to be implemented when the service/component allows
/// opening the component homepage through routing.
public protocol ServiceNavigationProvider {    
    /// Route identifier, which is the key of the route table.
    static var router: NavigationRouterURL { get }
    
    /// The route behavior event, which corresponds to the content of the key.
    ///
    /// You should implement this property as a computed property and return
    /// a `UIViewController` object or its subclass inside the closure.
    static var action: NavigationAction { get }
}
