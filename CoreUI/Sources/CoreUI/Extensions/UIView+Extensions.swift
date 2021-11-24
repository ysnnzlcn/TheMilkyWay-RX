//
//  UIView+Extensions.swift
//  
//
//  Created by Yasin Nazlican on 20.11.2021.
//

import UIKit

extension UIView {

    public func pinToSuperView(with margin: CGFloat = 0) {
        guard let superV = superview else { return }
        translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: superV.topAnchor, constant: margin),
            leftAnchor.constraint(equalTo: superV.leftAnchor, constant: margin),
            rightAnchor.constraint(equalTo: superV.rightAnchor, constant: -margin),
            bottomAnchor.constraint(equalTo: superV.bottomAnchor, constant: -margin)
            ]
        )
    }
}
