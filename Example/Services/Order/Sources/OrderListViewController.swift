//
//  OrderListViewController.swift
//  Order
//
//  Created by Rakuyo on 2023/03/20.
//

import UIKit

import OrderInterface
import RaModularCore
import RaModularRouter

class OrderListViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .red
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        print("\(self) viewDidAppear")
        
        Router.open(.init(OrderRouter.detail)) {
            print("push, then before detail viewDidAppear; present, then after detail viewDidAppear.")
        }
    }
    
    deinit {
        print("\(self) deinit")
    }
}

// MARK: - Navigatable

extension OrderListViewController: Navigatable {
    static var router: RouterURL {
        .init(OrderRouter.list)
    }
    
    static var routerBehavior: RouterTable.Value {
        { (url, mode, userInfo) in
            let vc = OrderListViewController()
            
            guard case .present = mode else { return vc }
            
            let navi = UINavigationController(rootViewController: vc)
            navi.modalPresentationStyle = .fullScreen
            return navi
        }
    }
}
