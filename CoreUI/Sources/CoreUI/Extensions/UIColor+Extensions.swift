//
//  UIColor+Extensions.swift
//  
//
//  Created by Yasin Nazlican on 18.11.2021.
//

import UIKit

public extension UIColor {

    // MARK: Private Static Predefined Colors

    private static let dark = UIColor(red: 21 / 255, green: 21 / 255, blue: 21 / 255, alpha: 1)
    private static let lighterDark = UIColor(red: 98 / 255, green: 98 / 255, blue: 98 / 255, alpha: 1)
    private static let veryLightGray = UIColor(red: 234 / 255, green: 234 / 255, blue: 234 / 255, alpha: 1)

    // MARK: Public Predefined Colors

    static let primaryTextColor: UIColor = .dark
    static let secondaryTextColor: UIColor = .lighterDark
    static let backgroundColor: UIColor = .white
    static let navBarBackgroundColor: UIColor = .veryLightGray
}
