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
    public func getRouterTarget(with userInfo: Parameters) -> NavigableViewControllerType? {
        let type = userInfo["type"] as? String
        
        switch type {
        case "detail":
            return OrderDetailViewController.self
            
        default:
            return OrderListViewController.self
        }
    }
}

// MARK: - UIApplicationDelegate

extension OrderServiceProvider: UIApplicationDelegate {
    public func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
    ) -> Bool {
        OrderListViewController.registerRouter() // ⬅️ This code is not required
        OrderDetailViewController.registerRouter()
        return true
    }
}

// MARK: - OrderServiceBehaviorProvider

extension OrderServiceProvider: OrderServiceBehaviorProvider {
    public func updateLocalOrderCache() -> Bool {
        print(#function)
        return true
    }
}
