//
//  RSVSequenceExtendable.swift
//  RaServices
//
//  Created by Rakuyo on 2023/03/23.
//  Copyright © 2023 Rakuyo. All rights reserved.
//

public struct RSVSequenceExtendable<Element> {
    /// Base object to extend.
    public var base: [Element]
    
    /// Creates extensions with base object.
    ///
    /// - parameter base: Base object.
    public init(_ base: [Element]) { self.base = base }
}

/// A type that has `RSVSequenceExtendable` extensions.
public protocol RSVSequenceExtendableCompatible {
    /// Extended type
    associatedtype Element
    
    /// `RSVSequenceExtendable` extensions.
    static var rsv: RSVSequenceExtendable<Element>.Type { get set }
    
    /// `RSVSequenceExtendable` extensions.
    var rsv: RSVSequenceExtendable<Element> { get set }
}

public extension RSVSequenceExtendableCompatible {
    /// A`rrayExtendable` extensions.
    static var rsv: RSVSequenceExtendable<Element>.Type {
        get { RSVSequenceExtendable<Element>.self }
        // swiftlint:disable:next unused_setter_value
        set { /* this enables using `RSVSequenceExtendable` to "mutate" base type */ }
    }
    
    /// `RSVSequenceExtendable` extensions.
    var rsv: RSVSequenceExtendable<Element> {
        get {
            guard let this = self as? [Element] else { return RSVSequenceExtendable([]) }
            return RSVSequenceExtendable(this)
        }
        // swiftlint:disable:next unused_setter_value
        set { /* this enables using `RSVSequenceExtendable` to "mutate" base object */ }
    }
}

// MARK: - Extend `rsv` proxy.

// swiftlint:disable colon
import struct Swift.Array;              extension Array             : RSVSequenceExtendableCompatible { }
import struct Swift.ContiguousArray;    extension ContiguousArray   : RSVSequenceExtendableCompatible { }
import struct Swift.Set;                extension Set               : RSVSequenceExtendableCompatible { }
// swiftlint:enable colon
