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
public protocol RSVNamespaceProvidable {
    /// Extended type
    associatedtype CompatibleType
    
    /// `RSVExtendable` extensions.
    static var rsv: RSVExtendable<CompatibleType>.Type { get set }
    
    /// `RSVExtendable` extensions.
    var rsv: RSVExtendable<CompatibleType> { get set }
}

public extension RSVNamespaceProvidable {
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
import struct Swift.String;             extension String            : RSVNamespaceProvidable { }
import struct Swift.Int;                extension Int               : RSVNamespaceProvidable { }
import struct Swift.Double;             extension Double            : RSVNamespaceProvidable { }
import struct Swift.Float;              extension Float             : RSVNamespaceProvidable { }
import struct Swift.Array;              extension Array             : RSVNamespaceProvidable { }
import struct Swift.ContiguousArray;    extension ContiguousArray   : RSVNamespaceProvidable { }
import struct Swift.Set;                extension Set               : RSVNamespaceProvidable { }
import class  Foundation.NSObject;      extension NSObject          : RSVNamespaceProvidable { }
import struct Foundation.Date;          extension Date              : RSVNamespaceProvidable { }
import struct Foundation.URL;           extension URL               : RSVNamespaceProvidable { }
import struct Foundation.Data;          extension Data              : RSVNamespaceProvidable { }
import struct UIKit.CGPoint;            extension CGPoint           : RSVNamespaceProvidable { }
import struct UIKit.CGSize;             extension CGSize            : RSVNamespaceProvidable { }
import struct UIKit.CGRect;             extension CGRect            : RSVNamespaceProvidable { }
// swiftlint:enable colon
