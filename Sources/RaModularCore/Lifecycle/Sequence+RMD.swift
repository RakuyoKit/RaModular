//
//  Sequence+RMD.swift
//  RaModular
//
//  Created by Rakuyo on 2023/03/23.
//  Copyright © 2023 Rakuyo. All rights reserved.
//

import Foundation

public extension RMDExtendable where Base: Sequence {
    @discardableResult
    func distribute<T>(_ block: (Base.Element) -> T?) -> [T] {
        return base.compactMap(block)
    }
    
    func distribute(_ block: (Base.Element) -> Bool?) -> Bool {
        return distribute(block).reduce(true) { $0 && $1 }
    }
    
    @discardableResult
    func distribute<T, S>(
        _ work: @escaping (Base.Element, @escaping (T) -> Void) -> S?,
        completion: @escaping ([T]) -> Void
    ) -> [S] {
        let dispatchGroup = DispatchGroup()
        var results: [T] = []
        var returns: [S] = []
        
        for element in base {
            dispatchGroup.enter()
            let returned = work(element) {
                results.append($0)
                dispatchGroup.leave()
            }
            
            if let returned = returned {
                returns.append(returned)
            } else {
                dispatchGroup.leave()
            }
        }
        
        dispatchGroup.notify(queue: .main) {
            completion(results)
        }
        
        return returns
    }
}
