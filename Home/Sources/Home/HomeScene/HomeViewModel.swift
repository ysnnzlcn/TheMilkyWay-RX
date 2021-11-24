//
//  HomeViewModel.swift
//  
//
//  Created by Yasin Nazlican on 18.11.2021.
//

import Combine
import Core

public enum HomeViewModelState {

    case toggleLoading(_ show: Bool)
    case itemSelected(_ item: NASAImage)
    case error(_ error: String)
}

public final class HomeViewModel {

    // MARK: Private Variables

    private let service: NASAServices
    private var cancellables = Set<AnyCancellable>()

    // MARK: Public Variables

    @Published public private(set) var items = [NASAImage]()
    @Published public private(set) var state: HomeViewModelState = .toggleLoading(false)

    // MARK: Life-Cycle

    public init(service: NASAServices) {
        self.service = service
    }

    // MARK: Public Methods

    public func didLoad() {
        getImages()
    }

    public func itemSelected(at index: Int) {
        state = .itemSelected(items[index])
    }
}

// MARK: Networking

extension HomeViewModel {

    private func getImages() {
        state = .toggleLoading(true)
        service
            .searchImages()
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .failure(let error):
                    self?.state = .error(error.customDescription)

                case .finished:
                    self?.state = .toggleLoading(false)
                }
            }, receiveValue: { [weak self] response in
                self?.items = response.collection.items
            })
            .store(in: &cancellables)
    }
}
