//
//  ViewController.swift
//  RaServicesExample
//
//  Created by Rakuyo on 2023/3/20.
//

import UIKit

import RaServices
//import RaServicesURLNavigate
import OrderInterface

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        _ = OrderService.behaviorProvider.updateLocalOrderCache()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        NavigationMode.default = .present
        
        OrderService.open(mode: .show(), animated: false) {
            print("after viewDidAppear")
        }
    }
}

