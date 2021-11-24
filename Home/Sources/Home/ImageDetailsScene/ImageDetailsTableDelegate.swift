//
//  ImageDetailsTableDelegate.swift
//  
//
//  Created by Yasin Nazlican on 20.11.2021.
//

import UIKit
import CoreUI

final public class ImageDetailsTableDelegate: NSObject {

    // MARK: Private Variables

    private let viewModel: ImageDetailsViewModel

    // MARK: Life-Cycle

    init(_ viewModel: ImageDetailsViewModel) {
        self.viewModel = viewModel
        super.init()
    }
}

// MARK: UITableViewDelegate

extension ImageDetailsTableDelegate: UITableViewDelegate {

    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch viewModel.items[indexPath.row].cell {
        case .imageHeaderCell:
            return Constants.imageCellHeight

        case .plainTextCell:
            return UITableView.automaticDimension
        }
    }
}

// MARK: Constants

extension ImageDetailsTableDelegate {

    private enum Constants {

        static let imageCellHeight: CGFloat = 230.0
    }
}
