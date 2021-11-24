//
//  Reusable.swift
//  
//
//  Created by Yasin Nazlican on 19.11.2021.
//

import Foundation

public protocol Reusable {

    static var reuseIdentifier: String { get }
    var reuseIdentifier: String { get }
}

public extension Reusable {

    static var reuseIdentifier: String {
        String(describing: self)
    }

    var reuseIdentifier: String {
        Self.reuseIdentifier
    }
}
