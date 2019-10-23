//
//  File.swift
//  
//
//  Created by Christian Seiler on 22.10.19.
//

#if canImport(AppKit)
import AppKit

public typealias Storyboard = NSStoryboard
public typealias ViewController = NSViewController
public typealias NibType = NSNib
public typealias ViewType = NSView
public typealias TableViewCell = NSCell
public typealias CollectionViewCell = NSCollectionViewItem
public typealias CollectionView = NSCollectionView
public typealias TableView = NSTableView
#elseif canImport(UIKit)
import UIKit
public typealias Storyboard = UIStoryboard
public typealias ViewController = UIViewController
public typealias NibType = UINib
public typealias ViewType = UIView
public typealias TableViewCell = UITableViewCell
public typealias CollectionViewCell = UICollectionViewCell
public typealias CollectionView = UICollectionView
public typealias TableView = UITableView
#endif
