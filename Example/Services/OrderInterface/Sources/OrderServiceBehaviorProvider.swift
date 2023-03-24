//
//  OrderServiceBehaviorProvider.swift
//  OrderInterface
//
//  Created by Rakuyo on 2023/03/20.
//

import Foundation

public protocol OrderServiceBehaviorProvider {
    func updateLocalOrderCache() -> Bool
}
