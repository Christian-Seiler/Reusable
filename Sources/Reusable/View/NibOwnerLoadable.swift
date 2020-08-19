//
//  NibOwnerLoadable.swift
//  Reusable
//
//  Created by Christian Seiler on 04.09.19.
//  Copyright © 2019 Christian Seiler. All rights reserved.
//

#if canImport(AppKit)
import AppKit
#elseif canImport(UIKit)
import UIKit
#endif

// MARK: Protocol Definition
/// Make your View subclasses conform to this protocol when:
///  * they *are* NIB-based, and
///  * this class is used as the XIB's File's Owner
///
/// to be able to instantiate them from the NIB in a type-safe manner
public protocol NibOwnerLoadable: class {
    /// The nib file to use to load a new instance of the View designed in a XIB
     var nib: NibType { get }
}

// MARK: Default implementation
public extension NibOwnerLoadable {
    /// By default, use the nib which have the same name as the name of the class,
    /// and located in the bundle of that class
     static var nib: NibType {

        #if os(macOS)
        return NibType(nibNamed: String(describing: self), bundle: Bundle(for: self))!
        #elseif os(iOS) || os(tvOS) || os(watchOS)
        return NibType(nibName: String(describing: self), bundle: Bundle(for: self))
        #endif
    }
}

// MARK: Support for instantiation from NIB
public extension NibOwnerLoadable where Self: ViewType {
    /**
     Adds content loaded from the nib to the end of the receiver's list of subviews and adds constraints automatically.
     */
     func loadNibContent() {
        let layoutAttributes: [NSLayoutConstraint.Attribute] = [.top, .leading, .bottom, .trailing]

        let view: [Any]
        #if os(macOS)
        var views: NSArray?
        Self.nib.instantiate(withOwner: nil, topLevelObjects: &views)
        view = views as! [Any]
        #else
        view = Self.nib.instantiate(withOwner: self, options: nil)
        #endif

        for case let view as ViewType in view {
            view.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(view)
            NSLayoutConstraint.activate(layoutAttributes.map { attribute in
                NSLayoutConstraint(item: view,
                                   attribute: attribute,
                                   relatedBy: .equal,
                                   toItem: self,
                                   attribute: attribute,
                                   multiplier: 1,
                                   constant: 0.0)
            })
        }
    }
}

/// Swift < 4.2 support
#if !(swift(>=4.2))
private extension NSLayoutConstraint {
    typealias Attribute = NSLayoutAttribute
}
#endif
