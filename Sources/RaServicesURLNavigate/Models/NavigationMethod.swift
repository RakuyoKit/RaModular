//
//  NavigationMethod.swift
//  RaServices
//
//  Created by Rakuyo on 2023/03/17.
//  Copyright © 2023 Rakuyo. All rights reserved.
//

import Foundation

public typealias NavigationMethod = Navigation.Method

public extension Navigation {
    /// Method used for navigating between view controllers.
    public enum Method {
        // `show(_:, sender:)`
        case show(sender: Any? = nil)
        
        // `showDetailViewController(_:, sender:)`
        case showDetail(sender: Any? = nil)
        
        // `pushViewController(_:, animated:)`
        case push(animated: Bool = true)
        
        // `present(_:, animated:, completion:)`
        case present(animated: Bool = true)
    }
}

// MARK: - Default

public extension Navigation.Method {
    /// The default navigation mode.
    /// You can set a default navigation mode that fits your business needs by modifying this property at runtime.
    static var `default`: Self = .show(sender: nil)
}

// MARK: - MethodType

public extension Navigation.Method {
    typealias MethodType = String
    
    var methodType: MethodType {
        switch self {
        case .show: return "show"
        case .showDetail: return "showDetail"
        case .push: return "push"
        case .present: return "present"
        }
    }
}

// MARK: - Init with components

public extension Navigation.Method {
    init?(methodType: MethodType, animated: Bool? = nil, sender: Any? = nil) {
        switch methodType {
        case Self.show().methodType:
            self = .show(sender: sender)
            
        case Self.showDetail().methodType:
            self = .showDetail(sender: sender)
            
        case Self.push().methodType:
            self = .push(animated: animated ?? true)
            
        case Self.present().methodType:
            self = .present(animated: animated ?? true)
            
        default:
            return nil
        }
    }
}
