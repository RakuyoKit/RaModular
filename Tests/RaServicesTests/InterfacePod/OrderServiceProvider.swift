//
//  File.swift
//  
//
//  Created by Rakuyo on 2023/3/20.
//

import Foundation

public protocol OrderServiceProvider {
    func updateLocalOrderCache() -> Bool
}
