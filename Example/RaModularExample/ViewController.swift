//
//  ViewController.swift
//  RaModularExample
//
//  Created by Rakuyo on 2023/03/20.
//

import UIKit

import OrderInterface
import RaModular

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        _ = OrderService.shared.behaviorProvider.updateLocalOrderCache()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        RouterMode.default = .present
        
        OrderService.shared.open(mode: .show()) {
            print("push, then before list viewDidAppear; present, then after list viewDidAppear.")
        }
    }
}

