//
//  OrderListViewController.swift
//  Order
//
//  Created by Rakuyo on 2023/3/20.
//

import UIKit

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
