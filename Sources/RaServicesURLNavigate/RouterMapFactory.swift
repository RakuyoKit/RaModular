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
    public typealias Factory = (_ userInfo: Parameters) -> Any?
    
    typealias Router = ServiceRouter
    
    private typealias Key = Router.Key
    
    static let shared = RouterMapFactory()
    
    private init() { }
    
    private lazy var cache: [Key: Factory] = [:]
}

extension RouterMapFactory {
    func cache(router: Router, with factory: @escaping Factory) {
        cache[router.key] = factory
    }
    
    func factory(of router: Router) -> Factory? {
        return cache[router.key]
    }
}
