//
//  RouterTable.swift
//  RaModular
//
//  Created by Rakuyo on 2023/03/17.
//  Copyright © 2023 Rakuyo. All rights reserved.
//

import Foundation

import RaModularCore

/// Router table, which stores registered routing events.
public typealias RouterTable = Router.Table

/// Represents a routing action and is also the value corresponding to the URL in the `RouterTable`.
public typealias RouterBehavior = RouterTable.Value

public extension Router {
    /// Router table, which stores registered routing events.
    ///
    /// Most methods of this type are for internal use within RaModular and are not exposed externally.
    public class Table {
        /// Key of the route table.
        private typealias Key = RouterURL.CacheKey
        
        /// Represents a routing action.
        public typealias Value = (_ url: RouterURL, _ mode: RouterMode, _ userInfo: Parameters) -> UIViewController?
        
        /// The routing table that is actually responsible for storing routing events.
        private static var table: [Key: Value] = [:]
        
        /// Accessing the routing table by subscript.
        ///
        /// - Parameters:
        ///   - url: Routing URL.
        ///   - covered: Whether to overwrite the existing value if it has already been registered.
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
