//
//  OrderListViewController.swift
//  Order
//
//  Created by Rakuyo on 2023/3/20.
//

import UIKit

import OrderInterface
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
        
        Navigation.open(.init(OrderRouter.detail)) {
            print("push, then before detail viewDidAppear; present, then after detail viewDidAppear.")
        }
    }
}

// MARK: - ViewControllerNavigable

extension OrderListViewController: ViewControllerNavigable {
    static var router: NavigationRouterURL {
        .init(OrderRouter.list)
    }
    
    static var routerBehavior: NavigationTable.Value {
        { (url, mode, userInfo) in
            let vc = OrderListViewController()
            
            guard case .present = mode else { return vc }
            
            let navi = UINavigationController(rootViewController: vc)
            navi.modalPresentationStyle = .fullScreen
            return navi
        }
    }
}
