//
//  OrderServiceEntrance.swift
//  OrderInterface
//
//  Created by Rakuyo on 2023/3/20.
//

import Foundation

import RaServices

public struct OrderServiceEntrance {
    public static let serviceProvider = OrderService()
}

// MARK: - ServiceProviding

extension OrderServiceEntrance: ServiceProviding {
    public typealias Provider = OrderServiceProvider
    
    public static func createProvider() -> Any {
        return serviceProvider
    }
}
