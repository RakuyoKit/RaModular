//
//  OrderDetailViewController.swift
//  Order
//
//  Created by Rakuyo on 2023/03/24.
//

import UIKit

import RaModularCore
import RaModularRouter

class OrderDetailViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .green
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        print("\(self) viewDidAppear")
    }
    
    deinit {
        print("\(self) deinit")
    }
}

// MARK: - Navigatable

extension OrderDetailViewController: Navigatable {
    static var router: RouterURL {
        .init(OrderRouter.detail)
    }
    
    static var routerBehavior: RouterTable.Value {
        { (url, mode, userInfo) in
            let vc = OrderDetailViewController()
            
            guard case .present = mode else { return vc }
            return UINavigationController(rootViewController: vc)
        }
    }
}
