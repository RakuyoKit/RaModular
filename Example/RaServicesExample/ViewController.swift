//
//  ViewController.swift
//  RaServicesExample
//
//  Created by Rakuyo on 2023/3/20.
//

import UIKit

import OrderInterface
import RaServices

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        _ = OrderService.shared.behaviorProvider.updateLocalOrderCache()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        NavigationMode.default = .present
        
        OrderService.shared.open(mode: .show()) {
            print("push, then before list viewDidAppear; present, then after list viewDidAppear.")
        }
    }
}

