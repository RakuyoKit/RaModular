//
//  RouterURL.swift
//  RaModular
//
//  Created by Rakuyo on 2023/03/17.
//  Copyright © 2023 Rakuyo. All rights reserved.
//

import Foundation

import RaModularCore

/// The route URL, which can be understood as the identifier of the route event.
public typealias RouterURL = Router.URL

extension Router {
    /// The route URL, which can be understood as the identifier of the route event.
    public struct URL {
        private let services: URLComponents?
        
        public init<T: RouterURLProviding>(_ value: T) {
            self.services = .init(string: value.router)
        }
        
        public init<T: RawRepresentable>(_ enumCase: T) where T.RawValue == String {
            self.init(enumCase.rawValue)
        }
    }
}

// MARK: - CacheKey

public extension Router.URL {
    typealias CacheKey = String
    
    /// Key of the route table.
    var cacheKey: CacheKey {
        scheme + "://" + host + (port.map { ":\($0)" } ?? "") + "/" + path + "/"
    }
}

// MARK: - URL services

public extension Router.URL {
    var scheme: String {
        services?.scheme ?? ""
    }
    
    var host: String {
        services?.host ?? ""
    }
    
    var port: Int? {
        services?.port
    }
    
    var path: String {
        services?.path ?? ""
    }
    
    var query: Parameters {
        services?.queryItems?.reduce(into: Parameters()) { $0[$1.name] = $1.value } ?? [:]
    }
}

// MARK: - Hashable

extension Router.URL: Hashable { }

// MARK: - CustomStringConvertible

extension Router.URL: CustomStringConvertible {
    public var description: String { services?.string ?? "nil" }
}

// MARK: - ExpressibleByStringLiteral

extension Router.URL: ExpressibleByStringLiteral {
    public init(stringLiteral value: StringLiteralType) {
        self.init(value)
    }
}
