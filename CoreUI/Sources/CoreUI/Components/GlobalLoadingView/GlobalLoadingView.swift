//
//  GlobalLoadingView.swift
//  
//
//  Created by Yasin Nazlican on 18.11.2021.
//

import Foundation
import UIKit

public enum GlobalLoadingView {

    // MARK: Cases

    case simple(_ tintColor: UIColor = .primaryTextColor)


    // MARK: Public Methods

    public func toggle(show: Bool, on viewController: UIViewController) {
        hide(on: viewController) /// Hide it before showing.
        if show {
            self.show(on: viewController)
        }
    }

    // MARK: Private Methods

    private func show(on viewController: UIViewController) {
        switch self {
        case .simple(let tintColor):
            addLoadingView(to: viewController.view, tintColor: tintColor)
        }
    }

    private func hide(on viewController: UIViewController) {
        viewController.view.subviews.filter { $0 is LoadingView }.forEach { $0.removeFromSuperview() }
    }

    private func addLoadingView(to superView: UIView, tintColor: UIColor) {
        /// Create loading view and add to hierarchy.
        let loadingView = LoadingView(activityColor: tintColor)
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        superView.addSubview(loadingView)

        /// Add constraints.
        loadingView.pinToSuperView()
    }
}
