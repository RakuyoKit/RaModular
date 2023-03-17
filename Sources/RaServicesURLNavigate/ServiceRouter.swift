//
//  ServiceURLNavigable.swift
//  RaServices
//
//  Created by Rakuyo on 2023/03/17.
//  Copyright © 2023 Rakuyo. All rights reserved.
//

import Foundation

public struct ServiceRouter {
    public let url: URL?
    
    public init(router: URL?) {
        self.url = router
    }
    
    public init(router: String) {
        self.url = .init(string: router)
    }
}

// MARK: - Hashable

extension ServiceRouter: Hashable { }

// MARK: - ExpressibleByStringLiteral

extension ServiceRouter: ExpressibleByStringLiteral {
    public init(stringLiteral value: StringLiteralType) {
        self.init(router: value)
    }
}
