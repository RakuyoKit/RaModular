//
//  NavigationMethod.swift
//  RaServices
//
//  Created by Rakuyo on 2023/03/17.
//  Copyright © 2023 Rakuyo. All rights reserved.
//

import Foundation

/// Method used for navigating between view controllers.
public enum NavigationMethod {
    // `show(_:, sender:)`
    case show(sender: Any? = nil)
    
    // `showDetailViewController(_:, sender:)`
    case showDetail(sender: Any? = nil)
    
    // `pushViewController(_:, animated:)`
    case push(animated: Bool)
    
    // `present(_:, animated:, completion:)`
    case present(animated: Bool)
}
