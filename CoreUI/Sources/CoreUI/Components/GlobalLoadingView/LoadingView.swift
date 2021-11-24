//
//  LoadingView.swift
//  
//
//  Created by Yasin Nazlican on 18.11.2021.
//

import UIKit

class LoadingView: UIView {

    // MARK: Private UI Variables

    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.style = Constants.ActivityIndicator.style
        activityIndicator.color = activityColor
        activityIndicator.startAnimating()
        return activityIndicator
    }()

    // MARK: Private Variables

    private let activityColor: UIColor

    // MARK: Life-Cycle

    init(activityColor: UIColor) {
        self.activityColor = activityColor
        super.init(frame: .zero)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Setup Views

    private func setupViews() {
        /// Add subviews
        addSubview(activityIndicator)

        /// Add constraints
        NSLayoutConstraint.activate([
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor)
            ]
        )
    }
}

// MARK: Constants

private extension LoadingView {

    enum Constants {

        enum ActivityIndicator {

            static let style: UIActivityIndicatorView.Style = .large
        }
    }
}
