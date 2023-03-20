//
//  NavigationFactory.swift
//  RaServices
//
//  Created by Rakuyo on 2023/03/17.
//  Copyright © 2023 Rakuyo. All rights reserved.
//

import Foundation

import RaServicesCore

public typealias NavigationFactory = Navigation.Factory

public typealias NavigationAction = NavigationFactory.Value

public extension Navigation {
    public class Factory {
        public typealias Value = (_ userInfo: Parameters) -> Any?
        
        typealias RouterURL = NavigationRouterURL
        
        private typealias Key = RouterURL.CacheKey
        
        static let shared = Factory()
        
        private init() { }
        
        private lazy var factory: [Key: Value] = [:]
        
        func cache(_ value: @escaping Value, to url: RouterURL) {
            factory[url.cacheKey] = value
        }
        
        func value(of url: RouterURL) -> Value? {
            return factory[url.cacheKey]
        }
    }
}
