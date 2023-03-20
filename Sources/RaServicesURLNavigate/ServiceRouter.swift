//
//  ServiceURLNavigable.swift
//  RaServices
//
//  Created by Rakuyo on 2023/03/17.
//  Copyright © 2023 Rakuyo. All rights reserved.
//

import Foundation

///
public struct ServiceRouter {
    ///
    public let urlComponents: URLComponents?
    
    public init(url: URL?) {
        self.init(string: url?.absoluteString ?? "")
    }
    
    public init(string: String) {
        self.urlComponents = .init(string: string)
    }
}

// MARK: - Key

public extension ServiceRouter {
    typealias Key = String
    
    var key: Key {
        scheme + "://" + host + (port.map { ":\($0)" } ?? "") + "/" + path + "/"
    }
}

// MARK: - URL Components

public extension ServiceRouter {
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

extension ServiceRouter: Hashable { }

// MARK: - CustomStringConvertible

extension ServiceRouter: CustomStringConvertible {
    public var description: String { urlComponents?.string ?? "nil" }
}

// MARK: - ExpressibleByStringLiteral

extension ServiceRouter: ExpressibleByStringLiteral {
    public init(stringLiteral value: StringLiteralType) {
        self.init(string: value)
    }
}
