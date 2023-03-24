//
//  RouterURLProviding.swift
//  RaServices
//
//  Created by Rakuyo on 2023/03/24.
//  Copyright © 2023 Rakuyo. All rights reserved.
//

import Foundation

import Foundation

public protocol RouterURLProviding {
    var router: String { get }
}

public extension RouterURLProviding where Self: RawRepresentable, Self.RawValue == String {
    var router: String { rawValue }
}

extension URL: RouterURLProviding {
    public var router: String { absoluteString }
}

extension String: RouterURLProviding {
    public var router: String { self }
}

extension Optional: RouterURLProviding where Wrapped: RouterURLProviding {
    public var router: String {
        map { $0.router } ?? ""
    }
}
