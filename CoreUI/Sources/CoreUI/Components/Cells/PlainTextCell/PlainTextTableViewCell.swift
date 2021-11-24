//
//  PlainTextTableViewCell.swift
//  
//
//  Created by Yasin Nazlican on 20.11.2021.
//

import UIKit

public final class PlainTextTableViewCell: UITableViewCell, Reusable {

    // MARK: Private UI Variables

    private lazy var label: UILabel = {
        let label = UILabel()
        label.numberOfLines = Constants.Label.numberOfLines
        return label
    }()

    // MARK: Public Variables

    public var labelText: NSAttributedString? {
        didSet {
            label.attributedText = labelText
        }
    }

    // MARK: Life-Cycle

    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubviews()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupSubviews()
    }

    // MARK: Setup Subviews

    private func setupSubviews() {
        /// Setup Main
        selectionStyle = Constants.Main.selectionStyle

        /// Add subviews
        contentView.addSubview(label)

        /// Add constraints to container view
        label.pinToSuperView(with: Constants.Label.margins)
    }
}

extension PlainTextTableViewCell {

    private enum Constants {

        enum Main {

            static let selectionStyle: UITableViewCell.SelectionStyle = .none
        }

        enum Label {

            static let margins: CGFloat = 16.0
            static let numberOfLines = 0
        }
    }
}
