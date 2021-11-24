//
//  HomeTableViewDataSource.swift
//  
//
//  Created by Yasin Nazlican on 19.11.2021.
//

import Combine
import CoreUI
import UIKit

final class HomeTableViewDataSource: BaseDiffableDataSource<HomeCellType> {

    // MARK: Private Variables

    private let viewModel: HomeViewModel
    private var cancellables = Set<AnyCancellable>()

    // MARK: Life-Cycle

    init(_ tableView: UITableView, _ viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(tableView: tableView) { tableView, indexPath, item -> UITableViewCell? in
            switch item.cell {
            case .imageCell(let cellViewModel):
                let imageCell = tableView.dequeueReusableCell(withIdentifier: ImageTableViewCell.reuseIdentifier, for: indexPath) as? ImageTableViewCell
                imageCell?.cellViewModel = cellViewModel
                return imageCell
            }
        }
        bindViewModel()
    }

    private func bindViewModel() {
        viewModel.$items
            .receive(on: RunLoop.main)
            .map { items in
                return items.map {
                    let cellViewModel = ImageTableCellViewModel(imageModel: $0)
                    return HomeTableViewDataSource.Item(cell: .imageCell(cellViewModel))
                }
            }
            .sink(receiveValue: { [weak self] items in
                self?.update(items: items)
            })
            .store(in: &cancellables)
    }
}

enum HomeCellType {

    case imageCell(_ cellViewModel: ImageTableCellViewModel)
}
