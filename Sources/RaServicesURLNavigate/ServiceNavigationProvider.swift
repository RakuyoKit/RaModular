//
//  ServiceNavigationProvider.swift
//  RaServices
//
//  Created by Rakuyo on 2023/03/17.
//  Copyright © 2023 Rakuyo. All rights reserved.
//

import Foundation

import RaServicesCore

/// The protocol to be implemented when the service/component allows
/// opening the component homepage through routing.
public protocol ServiceNavigationProvider {
    /// Get route target
    ///
    /// - Parameter userInfo: Parameters may be required when creating navigation objects. Or the value can be passed to some scenario and then different view controllers are returned in different scenarios.
    func getRouterTarget(with userInfo: Parameters) -> NavigableViewControllerType
}
