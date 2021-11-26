//
//  ImageDetailsViewController.swift
//  
//
//  Created by Yasin Nazlican on 20.11.2021.
//

import Core
import CoreUI
import UIKit
import RxSwift
import RxCocoa

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
    private var disposeBag = DisposeBag()
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
        bindTableView()
    }

    // MARK: Setup Views

    private func setupViews() {
        /// Setup main
        title = viewModel.imageTitle
        view.backgroundColor = Constants.MainView.backgroundColor

        /// Setup sub views
        view.addSubview(tableView)

        /// Add Constraints
        tableView.pinToSuperView()
    }

    private func bindTableView() {
        /// Bind data source
        viewModel.items
            .bind(to: tableView.rx.items) { (tableView, index, cellType) -> UITableViewCell in
                let indexPath = IndexPath(row: index, section: 0)
                var cell: UITableViewCell?
                switch cellType {
                case .imageHeaderCell(let url):
                    let imageCell = tableView.dequeueReusableCell(withIdentifier: ImageHeaderTableViewCell.reuseIdentifier, for: indexPath) as? ImageHeaderTableViewCell
                    imageCell?.url = url
                    cell = imageCell

                case .plainTextCell(let text):
                    let imageCell = tableView.dequeueReusableCell(withIdentifier: PlainTextTableViewCell.reuseIdentifier, for: indexPath) as? PlainTextTableViewCell
                    imageCell?.labelText = text
                    cell = imageCell
                }
                return cell ?? UITableViewCell()
            }
            .disposed(by: disposeBag)

        /// Bind delegate
        tableView
            .rx
            .setDelegate(tableDelegate)
            .disposed(by: disposeBag)
    }
}

public enum ImageDetailsCellType: Equatable {

    case imageHeaderCell(_ url: String?)
    case plainTextCell(_ text: NSAttributedString)
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
