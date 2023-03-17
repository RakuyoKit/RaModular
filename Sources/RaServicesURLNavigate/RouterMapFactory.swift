//
//  RouterMapFactory.swift
//  RaServices
//
//  Created by Rakuyo on 2023/03/17.
//  Copyright © 2023 Rakuyo. All rights reserved.
//

import Foundation

import RaServicesCore

public class RouterMapFactory {
    typealias Router = ServiceRouter
    
    public typealias Factory = (_ userInfo: Parameters) -> Any?
    
    static let shared = RouterMapFactory()
    
    private lazy var cache: [Router: Factory] = [:]
}

extension RouterMapFactory {
    func cache(router: Router, with factory: @escaping Factory) {
        
        #warning("TODO Here, the parameters in the URL should be discarded, and only the part before the parameters should be retained as the key.")
        
        cache[router] = factory
    }
    
    func factory(of router: Router) -> Factory? {
        
        #warning("TODO Here, the parameters in the URL should be discarded, and only the part before the parameters should be retained as the key.")
        
        return cache[router]
    }
}
