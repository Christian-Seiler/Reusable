//
//  CollectionView+Reusable.swift
//  Reusable
//
//  Created by Christian Seiler on 04.09.19.
//  Copyright © 2019 Christian Seiler. All rights reserved.
//

import Foundation

#if canImport(UIKit)
import UIKit

// MARK: Reusable support for CollectionView

public extension CollectionView {
    /**
     Register a NIB-Based `CollectionViewCell` subclass (conforming to `Reusable` & `NibLoadable`)
     - parameter cellType: the `CollectionViewCell` (`Reusable` & `NibLoadable`-conforming) subclass to register
     - seealso: `register(_:,forCellWithReuseIdentifier:)`
     */
    final func register<T: CollectionViewCell>(cellType: T.Type)
        where T: Reusable & NibLoadable {

            self.register(cellType.nib, forCellWithReuseIdentifier: cellType.reuseIdentifier)
    }

    /**
     Register a Class-Based `CollectionViewCell` subclass (conforming to `Reusable`)
     - parameter cellType: the `CollectionViewCell` (`Reusable`-conforming) subclass to register
     - seealso: `register(_:,forCellWithReuseIdentifier:)`
     */
     final func register<T: CollectionViewCell>(cellType: T.Type)
        where T: Reusable {
            self.register(cellType.self, forCellWithReuseIdentifier: cellType.reuseIdentifier)
    }

    /**
     Returns a reusable `CollectionViewCell` object for the class inferred by the return-type
     - parameter indexPath: The index path specifying the location of the cell.
     - parameter cellType: The cell class to dequeue
     - returns: A `Reusable`, `CollectionViewCell` instance
     - note: The `cellType` parameter can generally be omitted and infered by the return type,
     except when your type is in a variable and cannot be determined at compile time.
     - seealso: `dequeueReusableCell(withReuseIdentifier:,for:)`
     */
     final func dequeueReusableCell<T: CollectionViewCell>(for indexPath: IndexPath, cellType: T.Type = T.self) -> T
        where T: Reusable {
            let bareCell = self.dequeueReusableCell(withReuseIdentifier: cellType.reuseIdentifier, for: indexPath)
            guard let cell = bareCell as? T else {
                fatalError(
                    "Failed to dequeue a cell with identifier \(cellType.reuseIdentifier) matching type \(cellType.self). "
                        + "Check that the reuseIdentifier is set properly in your XIB/Storyboard "
                        + "and that you registered the cell beforehand"
                )
            }
            return cell
    }

    /**
     Register a NIB-Based `UICollectionReusableView` subclass (conforming to `Reusable` & `NibLoadable`)
     as a Supplementary View
     - parameter supplementaryViewType: the `UIView` (`Reusable` & `NibLoadable`-conforming) subclass
     to register as Supplementary View
     - parameter elementKind: The kind of supplementary view to create.
     - seealso: `register(_:,forSupplementaryViewOfKind:,withReuseIdentifier:)`
     */
    @available(iOS 6.0, tvOS 9.0, *)
     final func register<T: UICollectionReusableView>(supplementaryViewType: T.Type, ofKind elementKind: String)
        where T: Reusable & NibLoadable {
            self.register(
                supplementaryViewType.nib,
                forSupplementaryViewOfKind: elementKind,
                withReuseIdentifier: supplementaryViewType.reuseIdentifier
            )
    }

    /**
     Register a Class-Based `UICollectionReusableView` subclass (conforming to `Reusable`) as a Supplementary View
     - parameter supplementaryViewType: the `UIView` (`Reusable`-conforming) subclass to register as Supplementary View
     - parameter elementKind: The kind of supplementary view to create.
     - seealso: `register(_:,forSupplementaryViewOfKind:,withReuseIdentifier:)`
     */
    @available(iOS 6.0, tvOS 9.0, *)
     final func register<T: UICollectionReusableView>(supplementaryViewType: T.Type, ofKind elementKind: String)
        where T: Reusable {
            self.register(
                supplementaryViewType.self,
                forSupplementaryViewOfKind: elementKind,
                withReuseIdentifier: supplementaryViewType.reuseIdentifier
            )
    }

    /**
     Returns a reusable `CollectionReusableView` object for the class inferred by the return-type
     - parameter elementKind: The kind of supplementary view to retrieve.
     - parameter indexPath:   The index path specifying the location of the cell.
     - parameter viewType: The view class to dequeue
     - returns: A `Reusable`, `UICollectionReusableView` instance
     - note: The `viewType` parameter can generally be omitted and infered by the return type,
     except when your type is in a variable and cannot be determined at compile time.
     - seealso: `dequeueReusableSupplementaryView(ofKind:,withReuseIdentifier:,for:)`
     */
    @available(iOS 6.0, tvOS 9.0, *)
     final func dequeueReusableSupplementaryView<T: CollectionReusableView>
        (ofKind elementKind: String, for indexPath: IndexPath, viewType: T.Type = T.self) -> T
        where T: Reusable {
            let view = self.dequeueReusableSupplementaryView(
                ofKind: elementKind,
                withReuseIdentifier: viewType.reuseIdentifier,
                for: indexPath
            )
            guard let typedView = view as? T else {
                fatalError(
                    "Failed to dequeue a supplementary view with identifier \(viewType.reuseIdentifier) "
                        + "matching type \(viewType.self). "
                        + "Check that the reuseIdentifier is set properly in your XIB/Storyboard "
                        + "and that you registered the supplementary view beforehand"
                )
            }
            return typedView
    }
}
#endif
