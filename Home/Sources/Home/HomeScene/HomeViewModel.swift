//
//  HomeViewModel.swift
//  
//
//  Created by Yasin Nazlican on 18.11.2021.
//

import Core
import RxSwift
import RxCocoa

public enum HomeViewModelState {

    case toggleLoading(_ show: Bool)
    case error(_ error: String)
}

public final class HomeViewModel {

    // MARK: Private Variables

    private let service: NASAServices
    private var disposeBag = DisposeBag()

    // MARK: Public Variables

    public private(set) var items: PublishSubject<[NASAImage]> = PublishSubject()
    public private(set) var state: PublishSubject<HomeViewModelState> = PublishSubject()

    // MARK: Life-Cycle

    public init(service: NASAServices) {
        self.service = service
    }

    // MARK: Public Methods

    public func didLoad() {
        getImages()
    }
}

// MARK: Networking

extension HomeViewModel {

    private func getImages() {
        state.onNext(.toggleLoading(true))
        service
            .searchImages()
            .subscribe(onSuccess: { [weak self] response in
                self?.state.onNext(.toggleLoading(false))
                self?.items.onNext(response.collection.items)
            }, onFailure: { [weak self] error in
                self?.state.onNext(.toggleLoading(false))
                self?.state.onNext(.error((error as? NetworkError)?.customDescription ?? ""))
            })
            .disposed(by: disposeBag)
    }
}
