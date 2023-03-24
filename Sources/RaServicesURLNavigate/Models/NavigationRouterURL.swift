//
//  NavigationRouterURL.swift
//  RaServices
//
//  Created by Rakuyo on 2023/03/17.
//  Copyright © 2023 Rakuyo. All rights reserved.
//

import Foundation

import RaServicesCore

/// The route URL, which can be understood as the identifier of the route event.
public typealias NavigationRouterURL = Navigation.RouterURL

extension Navigation {
    /// The route URL, which can be understood as the identifier of the route event.
    public struct RouterURL {
        private let urlComponents: URLComponents?
        
        public init<T: RouterURLProviding>(_ value: T) {
            self.urlComponents = .init(string: value.router)
        }
        
        public init<T: RawRepresentable>(_ enumCase: T) where T.RawValue == String {
            self.init(enumCase.rawValue)
        }
    }
}

// MARK: - CacheKey

public extension Navigation.RouterURL {
    typealias CacheKey = String
    
    /// Key of the route table.
    var cacheKey: CacheKey {
        scheme + "://" + host + (port.map { ":\($0)" } ?? "") + "/" + path + "/"
    }
}

// MARK: - URL Components

public extension Navigation.RouterURL {
    var scheme: String {
        urlComponents?.scheme ?? ""
    }
    
    var host: String {
        urlComponents?.host ?? ""
    }
    
    var port: Int? {
        urlComponents?.port
    }
    
    var path: String {
        urlComponents?.path ?? ""
    }
    
    var query: Parameters {
        urlComponents?.queryItems?.reduce(into: Parameters()) { $0[$1.name] = $1.value } ?? [:]
    }
}

// MARK: - Hashable

extension Navigation.RouterURL: Hashable { }

// MARK: - CustomStringConvertible

extension Navigation.RouterURL: CustomStringConvertible {
    public var description: String { urlComponents?.string ?? "nil" }
}

// MARK: - ExpressibleByStringLiteral

extension Navigation.RouterURL: ExpressibleByStringLiteral {
    public init(stringLiteral value: StringLiteralType) {
        self.init(value)
    }
}
