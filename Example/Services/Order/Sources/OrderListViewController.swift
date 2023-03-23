//
//  OrderListViewController.swift
//  Order
//
//  Created by Rakuyo on 2023/3/20.
//

import UIKit

import RaServicesCore
import RaServicesURLNavigate

class OrderListViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .red
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        print("\(self) viewDidAppear")
    }
}

// MARK: - ViewControllerNavigable

enum OrderRouter: String {
    case list = "https://www.rakuyoo.com/order"
}

extension OrderListViewController: ViewControllerNavigable {
    static var router: NavigationRouterURL {
        .init(OrderRouter.list)
    }
    
    static func createRouterTarget(with userInfo: Parameters) -> UIViewController {
        return OrderListViewController()
    }
}
