//
//  StoryboardSceneBased.swift
//  Reusable
//
//  Created by Christian Seiler on 04.09.19.
//  Copyright © 2019 Christian Seiler. All rights reserved.
//

#if os(OSX)
import AppKit
#elseif os(iOS) || os(tvOS) || os(watchOS)
import UIKit
#endif

// MARK: Protocol Definition
/// Make your ViewController subclasses conform to this protocol when:
///  * they *are* Storyboard-based, and
///  * this ViewController is not the initialViewController of your Storyboard, but a different scene
///
/// to be able to instantiate them from the Storyboard in a type-safe manner.
///
/// You need to implement `sceneStoryboard` yourself to indicate the Storyboard this scene is from.
public protocol StoryboardSceneBased: class {
    /// The UIStoryboard to use when we want to instantiate this ViewController
    static var sceneStoryboard: Storyboard { get }
    /// The scene identifier to use when we want to instantiate this ViewController from its associated Storyboard
    static var sceneIdentifier: String { get }
}

// MARK: Default Implementation
public extension StoryboardSceneBased {
    /// By default, use the `sceneIdentifier` with the same name as the class
    static var sceneIdentifier: String {
        String(describing: self)
    }
}

// MARK: Support for instantiation from Storyboard
public extension StoryboardSceneBased where Self: ViewController {
    /**
     Create an instance of the ViewController from its associated Storyboard and the
     Scene with identifier `sceneIdentifier`
     - returns: instance of the conforming ViewController
     */
    static func instantiate() -> Self {
        let storyboard = Self.sceneStoryboard

        let viewController: ViewController?
        #if os(iOS) || os(tvOS) || os(watchOS)
        viewController = storyboard.instantiateViewController(withIdentifier: self.sceneIdentifier)
        #elseif os(macOS)
        viewController = sceneStoryboard.instantiateController(identifier: self.sceneIdentifier)
        #endif

        guard let typedViewController = viewController as? Self else {
            fatalError("The viewController '\(self.sceneIdentifier)' of '\(storyboard)' is not of class '\(self)'")
        }
        return typedViewController
    }
}
