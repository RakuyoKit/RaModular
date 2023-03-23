//
//  OrderService.swift
//  OrderInterface
//
//  Created by Rakuyo on 2023/3/20.
//

import Foundation

import RaServices

public struct OrderService: ServiceProviding {
    public typealias BehaviorProvider = OrderServiceBehaviorProvider
    
    public static let shared = OrderService()
    
    private init() { }
    
    public func createProvider() -> AnyObject {
        return OrderServiceProvider()
    }
}
