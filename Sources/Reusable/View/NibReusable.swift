//
//  NibReusable.swift
//  Reusable
//
//  Created by Christian Seiler on 04.09.19.
//  Copyright © 2019 Christian Seiler. All rights reserved.
//

import Foundation

// MARK: Protocol Definition
/// Make your View subclasses conform to this protocol when:
///  * they *are* NIB-based, and
///  * this class is used as the XIB's root view
///
/// to be able to instantiate them from the NIB in a type-safe manner
public protocol NibLoadable: class {
    /// The nib file to use to load a new instance of the View designed in a XIB
    static var nib: NibType { get }
}

// MARK: Default implementation
public extension NibLoadable {
    /// By default, use the nib which have the same name as the name of the class,
    /// and located in the bundle of that class
    static var nib: NibType {
        return NibType(nibName: String(describing: self), bundle: Bundle(for: self))
    }
}

// MARK: Support for instantiation from NIB
public extension NibLoadable where Self: ViewType {
    /**
     Returns a `View` object instantiated from nib
     - returns: A `NibLoadable`, `View` instance
     */
     static func loadFromNib() -> Self {
        guard let view = nib.instantiate(withOwner: nil, options: nil).first as? Self else {
            fatalError("The nib \(nib) expected its root view to be of type \(self)")
        }
        return view
    }
}
