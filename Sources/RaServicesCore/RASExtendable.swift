//
//  RASExtendable.swift
//  RaServices
//
//  Created by Rakuyo on 2023/03/17.
//  Copyright © 2023 Rakuyo. All rights reserved.
//

import Foundation

public struct RASExtendable<Base> {
    /// Base object to extend.
    public var base: Base
    
    /// Creates extensions with base object.
    ///
    /// - parameter base: Base object.
    public init(_ base: Base) { self.base = base }
}

/// A type that has `RASExtendable` extensions.
public protocol RASNamespaceProvidable {
    /// Extended type
    associatedtype CompatibleType
    
    /// `RASExtendable` extensions.
    static var ras: RASExtendable<CompatibleType>.Type { get set }
    
    /// `RASExtendable` extensions.
    var ras: RASExtendable<CompatibleType> { get set }
}

public extension RASNamespaceProvidable {
    /// `RASExtendable` extensions.
    static var ras: RASExtendable<Self>.Type {
        get { RASExtendable<Self>.self }
        // swiftlint:disable:next unused_setter_value
        set { /* this enables using `RASExtendable` to "mutate" base type */ }
    }
    
    /// `RASExtendable` extensions.
    var ras: RASExtendable<Self> {
        get { RASExtendable(self) }
        // swiftlint:disable:next unused_setter_value
        set { /* this enables using `RASExtendable` to "mutate" base object */ }
    }
}

// MARK: - Extend `ras` proxy.

// swiftlint:disable colon
import struct Swift.String;        extension String  : RASNamespaceProvidable { }
import struct Swift.Int;           extension Int     : RASNamespaceProvidable { }
import struct Swift.Double;        extension Double  : RASNamespaceProvidable { }
import struct Swift.Float;         extension Float   : RASNamespaceProvidable { }
import class  Foundation.NSObject; extension NSObject: RASNamespaceProvidable { }
import struct Foundation.Date;     extension Date    : RASNamespaceProvidable { }
import struct Foundation.URL;      extension URL     : RASNamespaceProvidable { }
import struct Foundation.Data;     extension Data    : RASNamespaceProvidable { }
import struct UIKit.CGPoint;       extension CGPoint : RASNamespaceProvidable { }
import struct UIKit.CGSize;        extension CGSize  : RASNamespaceProvidable { }
import struct UIKit.CGRect;        extension CGRect  : RASNamespaceProvidable { }
// swiftlint:enable colon
