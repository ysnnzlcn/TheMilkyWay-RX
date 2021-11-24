//
//  UINavigationBar+Extensions.swift
//  
//
//  Created by Yasin Nazlican on 20.11.2021.
//

import UIKit

public extension UINavigationBar {

    class func applyDefaultStyling() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .navBarBackgroundColor
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        if #available(iOS 15.0, *) {
            UINavigationBar.appearance().compactScrollEdgeAppearance = appearance
        }
    }
}
