//
//  HomeViewController.swift
//  
//
//  Created by Yasin Nazlican on 18.11.2021.
//

import Core
import CoreUI
import UIKit
import RxSwift
import RxCocoa

public protocol HomeViewControllerCoordinatorDelegate: AnyObject {

    func homeViewControllerDidSelect(
        _ sender: HomeViewController,
        image: NASAImage
    )
}

public final class HomeViewController: UIViewController {

    // MARK: Private UI Variables

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = Constants.TableView.separatorStyle
        tableView.backgroundColor = Constants.TableView.backgroundColor
        tableView.alwaysBounceVertical = Constants.TableView.alwaysBounceVertical
        tableView.keyboardDismissMode = Constants.TableView.keyboardDismissMode
        tableView.register(
            UINib(nibName: ImageTableViewCell.reuseIdentifier, bundle: CoreUIModule.module),
            forCellReuseIdentifier: ImageTableViewCell.reuseIdentifier
        )
        return tableView
    }()

    // MARK: Public Variables

    public weak var delegate: HomeViewControllerCoordinatorDelegate?

    // MARK: Private Variables

    private let viewModel: HomeViewModel
    private var disposeBag = DisposeBag()

    // MARK: Life-Cycle

    public init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        bindViewModel()
        viewModel.didLoad()
    }

    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateNavigationBarTitleStyle(largeTitles: true)
    }

    // MARK: Setup Views

    private func setupViews() {
        /// Setup main
        title = Constants.MainView.title
        view.backgroundColor = Constants.MainView.backgroundColor

        /// Setup sub views
        view.addSubview(tableView)

        /// Add Constraints
        tableView.pinToSuperView()
    }

    // MARK: Bind ViewModel

    private func bindViewModel() {
        bindTableView()
        bindState()
    }

    private func bindState() {
        viewModel.state
            .subscribe(onNext: { state in
                switch state {
                case .toggleLoading(let show):
                    GlobalLoadingView.simple().toggle(show: show, on: self)

                case .error(let error):
                    GlobalAlert.alert(
                        title: Constants.Alert.title,
                        message: error,
                        action: (
                            Constants.Alert.actionTitle,
                            { self.viewModel.didLoad() }
                        )
                    ).show(on: self)
                }
            })
            .disposed(by: disposeBag)
    }

    private func updateNavigationBarTitleStyle(largeTitles: Bool) {
        navigationController?.navigationBar.prefersLargeTitles = largeTitles
    }
}

extension HomeViewController {

    private func bindTableView() {
        viewModel.items
            .map { items -> [HomeCellType] in
                items.map { .imageCell(ImageTableCellViewModel(imageModel: $0)) }
            }
            .bind(to: tableView.rx.items) { (tableView, index, cellType) -> UITableViewCell in
                switch cellType {
                case .imageCell(let cellViewModel):
                    guard let imageCell = tableView.dequeueReusableCell(withIdentifier: ImageTableViewCell.reuseIdentifier, for: IndexPath(row: index, section: 0)) as? ImageTableViewCell else { return UITableViewCell() }
                    imageCell.cellViewModel = cellViewModel
                    return imageCell
                }
            }
            .disposed(by: disposeBag)
    }

    enum HomeCellType {

        case imageCell(_ cellViewModel: ImageTableCellViewModel)
    }
}

// MARK: Constants

extension HomeViewController {

    private enum Constants {

        enum MainView {

            static let title = "The Milky Way"
            static let backgroundColor: UIColor = .backgroundColor
        }

        enum TableView {

            static let keyboardDismissMode: UIScrollView.KeyboardDismissMode = .onDrag
            static let separatorStyle: UITableViewCell.SeparatorStyle = .none
            static let backgroundColor: UIColor = .backgroundColor
            static let alwaysBounceVertical = true
        }

        enum Alert {

            static let title = "That didn’t work!"
            static let actionTitle = "Retry"
        }
    }
}
