//
//  File.swift
//  
//
//  Created by Rakuyo on 2023/3/20.
//

import UIKit

@testable import RaServicesCore
@testable import RaServicesURLNavigate

extension OrderService: ServiceRouterProvider {
    public static var router: ServiceRouter {
        "https://www.rakuyoo.com/order"
    }
    
    public static var factory: Router.Factory {
        { _ in
            print("hhhhh")
            
            return UIViewController()
        }
    }
}
