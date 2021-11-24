//
//  UIFont+Extensions.swift
//  
//
//  Created by Yasin Nazlican on 18.11.2021.
//

import UIKit

public extension UIFont {

    static func appFont(size: CGFloat, weight: UIFont.Weight) -> UIFont {
        .systemFont(ofSize: size, weight: weight)
    }

    static func appFontBold(_ size: CGFloat) -> UIFont {
        .systemFont(ofSize: size, weight: .bold)
    }

    static func appFontRegular(_ size: CGFloat) -> UIFont {
        .systemFont(ofSize: size, weight: .regular)
    }
}
