//
//  RouterProvider.swift
//  RaModular
//
//  Created by Rakuyo on 2023/03/17.
//  Copyright © 2023 Rakuyo. All rights reserved.
//

import Foundation

import RaModularCore

/// Used to provide view controllers that are accessible externally within this service.
public protocol RouterProvider {
    /// Get the target view controller for routing.
    ///
    /// - Parameter userInfo: Parameters that may be required during the process of creating a view controller.
    func getRouterTarget(with userInfo: Parameters) -> NavigableViewControllerType?
}
