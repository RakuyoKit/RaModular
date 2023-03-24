//
//  OrderModule.swift
//  OrderInterface
//
//  Created by Rakuyo on 2023/03/20.
//

import Foundation

import RaModular

public struct OrderService: ServiceProviding {
    public typealias BehaviorProvider = OrderServiceBehaviorProvider
    
    public static let shared = OrderService()
    
    private init() { }
    
    public let weight: String = "a_b"
    
    public func createProvider() -> AnyObject {
        return OrderServiceProvider()
    }
}
