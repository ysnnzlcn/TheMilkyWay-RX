//
//  ImageDetailsViewModel.swift
//  
//
//  Created by Yasin Nazlican on 20.11.2021.
//

import Core
import CoreUI
import Foundation
import UIKit
import RxSwift
import RxCocoa

public final class ImageDetailsViewModel {

    // MARK: Private Variables

    private let service: NASAServices
    private let imageModel: NASAImage

    // MARK: Public Variables

    public var items: BehaviorRelay<[ImageDetailsCellType]> {
        .init(value: [
            ImageDetailsCellType.imageHeaderCell(imageModel.links.first?.percentageEncodedHref),
            ImageDetailsCellType.plainTextCell(headerText),
            ImageDetailsCellType.plainTextCell(descriptionText)
        ])
    }
    public var imageTitle: String { imageModel.info.first?.title ?? "" }

    // MARK: Life-Cycle

    public init(service: NASAServices, imageModel: NASAImage) {
        self.service = service
        self.imageModel = imageModel
    }
}

extension ImageDetailsViewModel {

    private var headerText: NSAttributedString {
        ImageTableCellViewModel(imageModel: imageModel).text
        /// We will use this cellViewModel to just get the attributed text, which is the same with the home page.
    }

    private var descriptionText: NSAttributedString {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.57

        return .init(
            string: imageModel.info.first?.imageDescription ?? "No description provided.",
            attributes: [
                .foregroundColor: UIColor.primaryTextColor,
                .font: UIFont.appFontRegular(16),
                .paragraphStyle: paragraphStyle
            ]
        )
    }
}
