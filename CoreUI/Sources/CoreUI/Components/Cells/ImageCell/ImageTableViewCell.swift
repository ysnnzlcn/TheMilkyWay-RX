//
//  ImageTableViewCell.swift
//  
//
//  Created by Yasin Nazlican on 19.11.2021.
//

import UIKit

public final class ImageTableViewCell: UITableViewCell, Reusable {

    @IBOutlet private var nasaImageView: AsyncImageView!
    @IBOutlet private var nasaLabel: UILabel!

    public var cellViewModel: ImageTableCellViewModel? {
        didSet {
            updateUI()
        }
    }

    public override func prepareForReuse() {
        super.prepareForReuse()
        nasaImageView.image = nil
    }

    private func updateUI() {
        if let imageURL = cellViewModel?.imageURL {
            nasaImageView.load(url: imageURL, cache: .shared)
        }
        nasaLabel.attributedText = cellViewModel?.text
    }
}
