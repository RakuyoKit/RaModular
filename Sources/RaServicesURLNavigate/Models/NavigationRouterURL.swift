//
//  NavigationRouterURL.swift
//  RaServices
//
//  Created by Rakuyo on 2023/03/17.
//  Copyright © 2023 Rakuyo. All rights reserved.
//

import Foundation

/// The route URL, which can be understood as the identifier of the route event.
public typealias NavigationRouterURL = Navigation.RouterURL

extension Navigation {
    /// The route URL, which can be understood as the identifier of the route event.
    public struct RouterURL {
        public let urlComponents: URLComponents?
        
        public init(url: Foundation.URL?) {
            self.init(string: url?.absoluteString ?? "")
        }
        
        public init(string: String) {
            self.urlComponents = .init(string: string)
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
    
    var query: [URLQueryItem] {
        urlComponents?.queryItems ?? []
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
        self.init(string: value)
    }
}
