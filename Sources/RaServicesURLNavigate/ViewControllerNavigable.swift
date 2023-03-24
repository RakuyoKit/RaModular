//
//  ViewControllerNavigable.swift
//  RaServicesURLNavigate
//
//  Created by Rakuyo on 2023/03/23.
//  Copyright © 2023 Rakuyo. All rights reserved.
//

import UIKit

import RaServicesCore

public typealias NavigableViewControllerType = ViewControllerNavigable.Type

/// Mark a view controller as accessible via URL navigation.
public protocol ViewControllerNavigable {
    /// Navigation identifier, which is the key of the route table.
    static var router: NavigationRouterURL { get }
    
    /// Used to create route destination controllers.
    static func createRouterTarget(with userInfo: Parameters) -> UIViewController
}

public extension ViewControllerNavigable {
    /// Register the navigation behavior into the routing table.
    static func registerRouter() {
        Navigation.register(router, with: createRouterTarget(with:))
    }
}
