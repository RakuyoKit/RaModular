//
//  NavigationMethod.swift
//  RaServices
//
//  Created by Rakuyo on 2023/03/17.
//  Copyright © 2023 Rakuyo. All rights reserved.
//

import Foundation

/// Method used for navigating between view controllers.
public typealias NavigationMode = Navigation.Mode

public extension Navigation {
    /// Method used for navigating between view controllers.
    public enum Mode {
        // `show(_:, sender:)`
        case show(sender: Any? = nil)
        
        // `showDetailViewController(_:, sender:)`
        case showDetail(sender: Any? = nil)
        
        // `pushViewController(_:, animated:)`
        case push
        
        // `present(_:, animated:, completion:)`
        case present
    }
}

// MARK: - Default

public extension Navigation.Mode {
    /// The default navigation mode.
    /// You can set a default navigation mode that fits your business needs by modifying this property at runtime.
    static var `default`: Self = .show(sender: nil)
}

// MARK: - MethodType

public extension Navigation.Mode {
    typealias Identifier = String
    
    /// Identifier for the navigation mode,
    /// which allows configuring the navigation mode through a string.
    ///
    /// see `init?(methodMode:, animated:, sender:)`
    var identifier: Identifier {
        switch self {
        case .show: return "show"
        case .showDetail: return "showDetail"
        case .push: return "push"
        case .present: return "present"
        }
    }
}

// MARK: - Init with components

public extension Navigation.Mode {
    /// Initialize a `Navigation.Mode` object with a series of component parameters.
    ///
    /// When the `identifier` parameter fails to match, the method will return `nil`.
    ///
    /// - Parameters:
    ///   - identifier: Navigation mode identifier, see `identifier` property for details.
    ///   - sender:
    init?(identifier: Identifier, sender: Any? = nil) {
        switch identifier {
        case Self.show().identifier:
            self = .show(sender: sender)
            
        case Self.showDetail().identifier:
            self = .showDetail(sender: sender)
            
        case Self.push.identifier:
            self = .push
            
        case Self.present.identifier:
            self = .present
            
        default:
            return nil
        }
    }
}
