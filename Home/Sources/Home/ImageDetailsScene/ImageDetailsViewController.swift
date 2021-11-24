//
//  ImageDetailsViewController.swift
//  
//
//  Created by Yasin Nazlican on 20.11.2021.
//

import Combine
import Core
import CoreUI
import UIKit

public final class ImageDetailsViewController: UIViewController {

    // MARK: Private UI Variables

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = Constants.TableView.separatorStyle
        tableView.backgroundColor = Constants.TableView.backgroundColor
        tableView.alwaysBounceVertical = Constants.TableView.alwaysBounceVertical
        tableView.keyboardDismissMode = Constants.TableView.keyboardDismissMode
        tableView.register(ImageHeaderTableViewCell.self, forCellReuseIdentifier: ImageHeaderTableViewCell.reuseIdentifier)
        tableView.register(PlainTextTableViewCell.self, forCellReuseIdentifier: PlainTextTableViewCell.reuseIdentifier)
        return tableView
    }()

    // MARK: Private Variables

    private let viewModel: ImageDetailsViewModel
    private lazy var tableDataSource = ImageDetailsTableDataSource(tableView, viewModel)
    private lazy var tableDelegate = ImageDetailsTableDelegate(viewModel)

    // MARK: Life-Cycle

    public init(viewModel: ImageDetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        viewModel.didLoad()
    }

    // MARK: Setup Views

    private func setupViews() {
        /// Setup main
        title = viewModel.imageTitle
        view.backgroundColor = Constants.MainView.backgroundColor

        /// Setup table view
        tableView.dataSource = tableDataSource
        tableView.delegate = tableDelegate

        /// Setup sub views
        view.addSubview(tableView)

        /// Add Constraints
        tableView.pinToSuperView()
    }
}

// MARK: Constants

extension ImageDetailsViewController {

    private enum Constants {

        enum MainView {

            static let backgroundColor: UIColor = .backgroundColor
        }

        enum TableView {

            static let keyboardDismissMode: UIScrollView.KeyboardDismissMode = .onDrag
            static let separatorStyle: UITableViewCell.SeparatorStyle = .none
            static let backgroundColor: UIColor = .backgroundColor
            static let alwaysBounceVertical = true
        }
    }
}
