//
//  RMDExtendable.swift
//  RaModular
//
//  Created by Rakuyo on 2023/03/17.
//  Copyright © 2023 Rakuyo. All rights reserved.
//

public struct RMDExtendable<Base> {
    /// Base object to extend.
    public var base: Base
    
    /// Creates extensions with base object.
    ///
    /// - parameter base: Base object.
    public init(_ base: Base) { self.base = base }
}

/// A type that has `RMDExtendable` extensions.
public protocol RMDNamespaceProviding {
    /// Extended type
    associatedtype CompatibleType
    
    /// `RMDExtendable` extensions.
    static var rmd: RMDExtendable<CompatibleType>.Type { get set }
    
    /// `RMDExtendable` extensions.
    var rmd: RMDExtendable<CompatibleType> { get set }
}

public extension RMDNamespaceProviding {
    /// `RMDExtendable` extensions.
    static var rmd: RMDExtendable<Self>.Type {
        get { RMDExtendable<Self>.self }
        // swiftlint:disable:next unused_setter_value
        set { /* this enables using `RMDExtendable` to "mutate" base type */ }
    }
    
    /// `RMDExtendable` extensions.
    var rmd: RMDExtendable<Self> {
        get { RMDExtendable(self) }
        // swiftlint:disable:next unused_setter_value
        set { /* this enables using `RMDExtendable` to "mutate" base object */ }
    }
}

// MARK: - Extend `rmd` proxy.

// swiftlint:disable colon
import struct Swift.String;             extension String            : RMDNamespaceProviding { }
import struct Swift.Int;                extension Int               : RMDNamespaceProviding { }
import struct Swift.Double;             extension Double            : RMDNamespaceProviding { }
import struct Swift.Float;              extension Float             : RMDNamespaceProviding { }
import struct Swift.Array;              extension Array             : RMDNamespaceProviding { }
import struct Swift.ContiguousArray;    extension ContiguousArray   : RMDNamespaceProviding { }
import struct Swift.Set;                extension Set               : RMDNamespaceProviding { }
import class  Foundation.NSObject;      extension NSObject          : RMDNamespaceProviding { }
import struct Foundation.Date;          extension Date              : RMDNamespaceProviding { }
import struct Foundation.URL;           extension URL               : RMDNamespaceProviding { }
import struct Foundation.Data;          extension Data              : RMDNamespaceProviding { }
import struct UIKit.CGPoint;            extension CGPoint           : RMDNamespaceProviding { }
import struct UIKit.CGSize;             extension CGSize            : RMDNamespaceProviding { }
import struct UIKit.CGRect;             extension CGRect            : RMDNamespaceProviding { }
// swiftlint:enable colon
