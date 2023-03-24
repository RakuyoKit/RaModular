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
public typealias NavigationBehavior = NavigationTable.Value

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
        public typealias Value = (_ url: NavigationRouterURL, _ mode: NavigationMode, _ userInfo: Parameters) -> UIViewController?
        
        /// Responsible for storing navigation behavior.
        private static var table: [Key: Value] = [:]
        
        static subscript(url: RouterURL, isCovered covered: Bool = true) -> Value? {
            get { table[url.cacheKey] }
            set {
                let key = url.cacheKey
                if covered {
                    table[key] = newValue
                    
                } else if _fastPath(table[key] == nil) {
                    table[key] = newValue
                }
            }
        }
    }
}
