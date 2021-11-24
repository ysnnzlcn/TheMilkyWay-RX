//
//  HomeTableViewDelegate.swift
//  
//
//  Created by Yasin Nazlican on 19.11.2021.
//

import UIKit

final public class HomeTableViewDelegate: NSObject {

    // MARK: Private Variables

    private let viewModel: HomeViewModel

    // MARK: Life-Cycle

    init(_ viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init()
    }
}

// MARK: UITableViewDelegate

extension HomeTableViewDelegate: UITableViewDelegate {

    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.itemSelected(at: indexPath.row)
    }
}
