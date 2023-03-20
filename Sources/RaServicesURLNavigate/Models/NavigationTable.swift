//
//  NavigationTable.swift
//  RaServices
//
//  Created by Rakuyo on 2023/03/17.
//  Copyright © 2023 Rakuyo. All rights reserved.
//

import Foundation

import RaServicesCore

/// Route table, which stores registered route implementations.
public typealias NavigationTable = Navigation.Table

/// Route behavior corresponding to the route in the route table.
public typealias NavigationAction = NavigationTable.Value

public extension Navigation {
    /// Route table, which stores registered route implementations.
    ///
    /// Most methods of this type are for internal use within RaServices and are not exposed externally.
    public class Table {
        ///
        typealias RouterURL = NavigationRouterURL
        
        /// Key value for the route table.
        private typealias Key = RouterURL.CacheKey
        
        /// Route behavior corresponding to the route in the route table.
        public typealias Value = (_ userInfo: Parameters) -> Any?
        
        /// Singleton.
        static let shared = Table()
        
        private init() { }
        
        private lazy var table: [Key: Value] = [:]
        
        func save(_ value: @escaping Value, to url: RouterURL) {
            table[url.cacheKey] = value
        }
        
        func value(of url: RouterURL) -> Value? {
            return table[url.cacheKey]
        }
    }
}
