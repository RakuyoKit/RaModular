//
//  RouterMode.swift
//  RaModular
//
//  Created by Rakuyo on 2023/03/17.
//  Copyright © 2023 Rakuyo. All rights reserved.
//

import Foundation

/// Methods of transitioning between view controllers.
public typealias RouterMode = Router.Mode

public extension Router {
    /// Methods of transitioning between view controllers.
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

public extension Router.Mode {
    /// The default transition style, which can be set globally through this property.
    static var `default`: Self = .show(sender: nil)
}

// MARK: - MethodType

public extension Router.Mode {
    typealias Identifier = String
    
    /// Identifier for the switching method.
    ///
    /// see `init?(identifier: sender:)`
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

public extension Router.Mode {
    /// Use the switching method identifier to initialize `Router.Mode`.
    ///
    /// When the `identifier` parameter fails to match, the method will return `nil`.
    ///
    /// - Parameters:
    ///   - identifier: Router mode identifier, see `identifier` property for details.
    ///   - sender: Applicable to the `show`.
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
