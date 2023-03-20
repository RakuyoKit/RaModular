//
//  OrderServiceProvider+ServiceNavigationProvider.swift
//  Order
//
//  Created by Rakuyo on 2023/3/20.
//

import UIKit

import OrderInterface
import RaServicesCore
import RaServicesURLNavigate

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
