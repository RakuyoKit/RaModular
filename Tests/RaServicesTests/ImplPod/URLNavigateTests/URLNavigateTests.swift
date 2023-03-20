//
//  File.swift
//  
//
//  Created by Rakuyo on 2023/3/20.
//

import XCTest

@testable import RaServicesURLNavigate

class URLNavigateTests: XCTestCase {
    override class func setUp() {
        OrderServiceEntrance.registerRouter()
    }
    
    func test() {
        OrderServiceEntrance.open(by: .push()) { }
        
//        OrderService._router
//
//        print(OrderService.routerWrapper)
    }
}
