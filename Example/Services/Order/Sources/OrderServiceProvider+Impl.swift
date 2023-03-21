//
//  OrderServiceProvider+Impl.swift
//  Order
//
//  Created by Rakuyo on 2023/03/21.
//

import UIKit

import OrderInterface
import RaServicesCore
import RaServicesURLNavigate

// MARK: - ServiceNavigationProvider

extension OrderServiceProvider: ServiceNavigationProvider {
    public static var router: NavigationRouterURL {
        "https://www.rakuyoo.com/order"
    }
    
    public static var action: NavigationAction {
        { _ in
            print("hhhhh")
            return OrderListViewController()
        }
    }
}

// MARK: - OrderServiceBehaviorProvider

extension OrderServiceProvider: OrderServiceBehaviorProvider {
    public func updateLocalOrderCache() -> Bool {
        print(#function)
        return true
    }
}
