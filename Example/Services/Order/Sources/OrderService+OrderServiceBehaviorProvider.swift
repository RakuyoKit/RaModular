//
//  OrderServiceProvider+OrderServiceBehaviorProvider.swift
//  Order
//
//  Created by Rakuyo on 2023/3/20.
//

import UIKit

import OrderInterface

extension OrderServiceProvider: OrderServiceBehaviorProvider {
    public func updateLocalOrderCache() -> Bool {
        print(#function)
        return true
    }
}
