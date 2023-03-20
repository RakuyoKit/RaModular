//
//  OrderService+ServiceRouterProvider.swift
//  Order
//
//  Created by Rakuyo on 2023/3/20.
//

import UIKit

import OrderInterface
import RaServicesCore
import RaServicesURLNavigate

extension OrderService: ServiceRouterProvider {
    public static var router: ServiceRouter {
        "https://www.rakuyoo.com/order"
    }
    
    public static var factory: Router.Factory {
        { _ in
            print("hhhhh")
            
            let vc = UIViewController()
            vc.view.backgroundColor = .red
            
            return vc
        }
    }
}
