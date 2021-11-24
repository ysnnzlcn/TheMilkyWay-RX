//
//  ImageHeaderTableViewCell.swift
//  
//
//  Created by Yasin Nazlican on 20.11.2021.
//

import UIKit

public final class ImageHeaderTableViewCell: UITableViewCell, Reusable {

    // MARK: Private UI Variables

    private lazy var nasaImageView: AsyncImageView = {
        let imageView = AsyncImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = Constants.ImageView.contentMode
        imageView.clipsToBounds = Constants.ImageView.clipsToBounds
        return imageView
    }()

    // MARK: Public Variables

    public var url: String? {
        didSet {
            if let urlString = url, let url = URL(string: urlString) {
                nasaImageView.load(url: url, cache: .shared)
            }
        }
    }

    // MARK: Life-Cycle

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }

    public override func prepareForReuse() {
        super.prepareForReuse()
        nasaImageView.image = nil
    }

    // MARK: Setup Views

    private func setupViews() {
        /// Main View
        selectionStyle = Constants.MainView.selectionStyle

        /// Image View
        addSubview(nasaImageView)
        nasaImageView.pinToSuperView()
    }
}

// MARK: Constants

extension ImageHeaderTableViewCell {

    private enum Constants {

        enum MainView {

            static let selectionStyle: UITableViewCell.SelectionStyle = .none
        }

        enum ImageView {

            static let contentMode: UIView.ContentMode = .scaleAspectFill
            static let clipsToBounds = true
        }
    }
}
