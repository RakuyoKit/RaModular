//
//  RSVExtendable.swift
//  RaServices
//
//  Created by Rakuyo on 2023/03/17.
//  Copyright © 2023 Rakuyo. All rights reserved.
//

public struct RSVExtendable<Base> {
    /// Base object to extend.
    public var base: Base
    
    /// Creates extensions with base object.
    ///
    /// - parameter base: Base object.
    public init(_ base: Base) { self.base = base }
}

/// A type that has `RSVExtendable` extensions.
public protocol RSVNamespaceProviding {
    /// Extended type
    associatedtype CompatibleType
    
    /// `RSVExtendable` extensions.
    static var rsv: RSVExtendable<CompatibleType>.Type { get set }
    
    /// `RSVExtendable` extensions.
    var rsv: RSVExtendable<CompatibleType> { get set }
}

public extension RSVNamespaceProviding {
    /// `RSVExtendable` extensions.
    static var rsv: RSVExtendable<Self>.Type {
        get { RSVExtendable<Self>.self }
        // swiftlint:disable:next unused_setter_value
        set { /* this enables using `RSVExtendable` to "mutate" base type */ }
    }
    
    /// `RSVExtendable` extensions.
    var rsv: RSVExtendable<Self> {
        get { RSVExtendable(self) }
        // swiftlint:disable:next unused_setter_value
        set { /* this enables using `RSVExtendable` to "mutate" base object */ }
    }
}

// MARK: - Extend `rsv` proxy.

// swiftlint:disable colon
import struct Swift.String;             extension String            : RSVNamespaceProviding { }
import struct Swift.Int;                extension Int               : RSVNamespaceProviding { }
import struct Swift.Double;             extension Double            : RSVNamespaceProviding { }
import struct Swift.Float;              extension Float             : RSVNamespaceProviding { }
import struct Swift.Array;              extension Array             : RSVNamespaceProviding { }
import struct Swift.ContiguousArray;    extension ContiguousArray   : RSVNamespaceProviding { }
import struct Swift.Set;                extension Set               : RSVNamespaceProviding { }
import class  Foundation.NSObject;      extension NSObject          : RSVNamespaceProviding { }
import struct Foundation.Date;          extension Date              : RSVNamespaceProviding { }
import struct Foundation.URL;           extension URL               : RSVNamespaceProviding { }
import struct Foundation.Data;          extension Data              : RSVNamespaceProviding { }
import struct UIKit.CGPoint;            extension CGPoint           : RSVNamespaceProviding { }
import struct UIKit.CGSize;             extension CGSize            : RSVNamespaceProviding { }
import struct UIKit.CGRect;             extension CGRect            : RSVNamespaceProviding { }
// swiftlint:enable colon
