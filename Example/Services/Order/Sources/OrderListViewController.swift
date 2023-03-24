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
        
        OrderService.shared.open(with: ["type": "detail"]) {
            print("push, then before detail viewDidAppear; present, then after detail viewDidAppear.")
        }
    }
}

// MARK: - ViewControllerNavigable

extension OrderListViewController: ViewControllerNavigable {
    static var router: NavigationRouterURL {
        .init(OrderRouter.list)
    }
    
    static func createRouterTarget(mode: NavigationMode, userInfo: Parameters) -> UIViewController {
        let vc = OrderListViewController()
        
        guard case .present = mode else { return vc }
        
        let navi = UINavigationController(rootViewController: vc)
        navi.modalPresentationStyle = .fullScreen
        return navi
    }
}
