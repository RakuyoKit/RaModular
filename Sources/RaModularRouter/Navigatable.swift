//
//  Navigatable.swift
//  RaModular
//
//  Created by Rakuyo on 2023/03/23.
//  Copyright © 2023 Rakuyo. All rights reserved.
//

import UIKit

import RaModularCore

public typealias NavigableViewControllerType = Navigatable.Type

/// A view controller that can be displayed through routing.
public protocol Navigatable {
    /// The routing value accepted by this view controller.
    static var router: RouterURL { get }
    
    /// Routing behavior, which is the process of creating a view controller through routing.
    static var routerBehavior: RouterBehavior { get }
}

public extension Navigatable {
    /// Registered Routing.
    static func registerRouter() {
        Router.register(router, with: routerBehavior)
    }
}
