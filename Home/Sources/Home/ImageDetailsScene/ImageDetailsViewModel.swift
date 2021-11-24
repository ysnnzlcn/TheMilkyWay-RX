//
//  ImageDetailsViewModel.swift
//  
//
//  Created by Yasin Nazlican on 20.11.2021.
//

import Combine
import Core
import CoreUI
import Foundation
import UIKit

public final class ImageDetailsViewModel {

    // MARK: Private Variables

    private let service: NASAServices
    private let imageModel: NASAImage

    // MARK: Public Variables

    @Published public private(set) var items = [ImageDetailsTableDataSource.Item]()
    public var imageTitle: String { imageModel.info.first?.title ?? "" }

    // MARK: Life-Cycle

    public init(service: NASAServices, imageModel: NASAImage) {
        self.service = service
        self.imageModel = imageModel
    }

    // MARK: Public Methods

    public func didLoad() {
        items = [
            .init(cell: .imageHeaderCell(imageModel.links.first?.percentageEncodedHref)),
            .init(cell: .plainTextCell(headerText)),
            .init(cell: .plainTextCell(descriptionText))
        ]
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
