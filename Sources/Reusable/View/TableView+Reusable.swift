//
//  TableView+Reusable.swift
//  Reusables
//
//  Created by Christian Seiler on 04.09.19.
//  Copyright © 2019 Christian Seiler. All rights reserved.
//

import Foundation

#if canImport(UIKit)
import UIKit

// MARK: Reusable support for TableView
public extension TableView {
    /**
     Register a NIB-Based `TableViewCell` subclass (conforming to `Reusable` & `NibLoadable`)
     - parameter cellType: the `TableViewCell` (`Reusable` & `NibLoadable`-conforming) subclass to register
     - seealso: `register(_:,forCellReuseIdentifier:)`
     */
      func register<T: TableViewCell>(cellType: T.Type)
        where T: Reusable & NibLoadable {
            self.register(cellType.nib,
                          forCellReuseIdentifier: cellType.reuseIdentifier)
    }

    /**
     Register a Class-Based `TableViewCell` subclass (conforming to `Reusable`)
     - parameter cellType: the `TableViewCell` (`Reusable`-conforming) subclass to register
     - seealso: `register(_:,forCellReuseIdentifier:)`
     */
     final func register<T: TableViewCell>(cellType: T.Type)
        where T: Reusable {
            self.register(cellType.self,
                          forCellReuseIdentifier: cellType.reuseIdentifier)
    }

    /**
     Returns a reusable `TableViewCell` object for the class inferred by the return-type
     - parameter indexPath: The index path specifying the location of the cell.
     - parameter cellType: The cell class to dequeue
     - returns: A `Reusable`, `TableViewCell` instance
     - note: The `cellType` parameter can generally be omitted and infered by the return type,
     except when your type is in a variable and cannot be determined at compile time.
     - seealso: `dequeueReusableCell(withIdentifier:,for:)`
     */
    @available(iOS 6.0, tvOS 9.0, *)
     final func dequeueReusableCell<T: TableViewCell>(for indexPath: IndexPath,
                                                      cellType: T.Type = T.self) -> T where T: Reusable {
            guard let cell = self.dequeueReusableCell(withIdentifier: cellType.reuseIdentifier,
                                                      for: indexPath) as? T else {
                fatalError(
                    "Failed to dequeue a cell with identifier \(cellType.reuseIdentifier) matching type \(cellType.self). "
                        + "Check that the reuseIdentifier is set properly in your XIB/Storyboard "
                        + "and that you registered the cell beforehand"
                )
            }
            return cell
    }
    /**
     Register a NIB-Based `UITableViewHeaderFooterView` subclass (conforming to `Reusable` & `NibLoadable`)
     - parameter headerFooterViewType: the `UITableViewHeaderFooterView` (`Reusable` & `NibLoadable`-conforming)
     subclass to register
     - seealso: `register(_:,forHeaderFooterViewReuseIdentifier:)`
     */
    @available(iOS 6.0, tvOS 9.0, macOS 13.0, *)
     final func register<T: UITableViewHeaderFooterView>(headerFooterViewType: T.Type) where T: Reusable & NibLoadable {
            self.register(headerFooterViewType.nib, forHeaderFooterViewReuseIdentifier: headerFooterViewType.reuseIdentifier)
    }

    /**
     Register a Class-Based `UITableViewHeaderFooterView` subclass (conforming to `Reusable`)
     - parameter headerFooterViewType: the `UITableViewHeaderFooterView` (`Reusable`-confirming) subclass to register
     - seealso: `register(_:,forHeaderFooterViewReuseIdentifier:)`
     */
    @available(iOS 6.0, tvOS 9.0, *)
    final func register<T: UITableViewHeaderFooterView>(headerFooterViewType: T.Type)
        where T: Reusable {
            self.register(headerFooterViewType.self,
                          forHeaderFooterViewReuseIdentifier: headerFooterViewType.reuseIdentifier)
    }

    /**
     Returns a reusable `UITableViewHeaderFooterView` object for the class inferred by the return-type
     - parameter viewType: The view class to dequeue
     - returns: A `Reusable`, `TableViewHeaderFooterView` instance
     - note: The `viewType` parameter can generally be omitted and infered by the return type,
     except when your type is in a variable and cannot be determined at compile time.
     - seealso: `dequeueReusableHeaderFooterView(withIdentifier:)`
     */
    @available(iOS 6.0, tvOS 9.0, *)
     final func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>(_ viewType: T.Type = T.self) -> T
        where T: Reusable {

            guard let view = self.dequeueReusableHeaderFooterView(withIdentifier: viewType.reuseIdentifier) as? T else {
                fatalError(
                    "Failed to dequeue a header/footer with identifier \(viewType.reuseIdentifier) "
                        + "matching type \(viewType.self). "
                        + "Check that the reuseIdentifier is set properly in your XIB/Storyboard "
                        + "and that you registered the header/footer beforehand"
                )
            }
            return view
    }
}
#endif
