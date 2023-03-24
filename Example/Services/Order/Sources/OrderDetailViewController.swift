//
//  OrderDetailViewController.swift
//  Order
//
//  Created by Rakuyo on 2023/3/24.
//

import UIKit

import RaServicesCore
import RaServicesURLNavigate

class OrderDetailViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .green
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        print("\(self) viewDidAppear")
    }
}

// MARK: - ViewControllerNavigable

extension OrderDetailViewController: ViewControllerNavigable {
    static var router: NavigationRouterURL {
        .init(OrderRouter.detail)
    }
    
    static func createRouterTarget(with userInfo: Parameters) -> UIViewController {
        let vc = OrderDetailViewController()
        vc.modalPresentationStyle = .fullScreen
        return vc
    }
}
