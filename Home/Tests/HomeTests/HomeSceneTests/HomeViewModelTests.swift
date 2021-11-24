//
//  HomeViewModelTests.swift
//  
//
//  Created by Yasin Nazlican on 20.11.2021.
//

import Combine
import Core
import Home
import XCTest

final class HomeViewModelTests: XCTestCase {

    private var sut: HomeViewModel!
    private var mockNasaService: MockNASAServices!
    private var cancellables: Set<AnyCancellable> = []

    override func setUp() {
        super.setUp()
        mockNasaService = MockNASAServices()
        sut = HomeViewModel(service: mockNasaService)
    }

    override func tearDown() {
        cancellables.forEach { $0.cancel() }
        cancellables.removeAll()
        mockNasaService = nil
        sut = nil
        super.tearDown()
    }

    func test_didLoad_shouldCallService() {
        // when
        sut.didLoad()

        // then
        XCTAssertEqual(mockNasaService.searchImagesCallsCount, 1)
    }

    func test_givenServiceCallSucceeds_shouldUpdatePlayers() {
        // given
        mockNasaService.searchImagesResult = .success(NASAImageResponse.mock)
        var loaderCalled = false

        // when
        sut.didLoad()

        // then
        XCTAssertEqual(mockNasaService.searchImagesCallsCount, 1)
        sut.$items
            .sink { XCTAssertEqual($0, NASAImageResponse.mock.collection.items) }
            .store(in: &cancellables)

        sut.$state
            .sink { (state: HomeViewModelState) in
                switch state {
                case .toggleLoading:
                    loaderCalled = true

                default: break /// Won't be tested in this scenario.
                }
            }
            .store(in: &cancellables)
        XCTAssertTrue(loaderCalled)
    }

    func test_givenServiceCallFails_shouldUpdateStateWithError() {
        // given
        let errorMessage = "Mock Error"
        mockNasaService.searchImagesResult = .failure(NetworkError.mock(error: errorMessage))

        // when
        sut.didLoad()

        // then
        XCTAssertEqual(mockNasaService.searchImagesCallsCount, 1)
        sut.$items
            .sink { XCTAssert($0.isEmpty) }
            .store(in: &cancellables)

        sut.$state
            .sink { state in
                switch state {
                case .error(let error):
                    XCTAssertEqual(error, errorMessage)

                default: break /// Won't be tested in this scenario.
                }
            }
            .store(in: &cancellables)
    }

    func test_itemSelected_shouldUpdateStateWithNavigation() {
        // given
        mockNasaService.searchImagesResult = .success(NASAImageResponse.mock)
        let selectedIndex = 0

        // when
        sut.didLoad()

        // then
        XCTAssertEqual(mockNasaService.searchImagesCallsCount, 1)
        sut.$items
            .sink { XCTAssertEqual($0, NASAImageResponse.mock.collection.items) }
            .store(in: &cancellables)

        // then
        sut.itemSelected(at: selectedIndex)

        // then
        sut.$state
            .sink { state in
                switch state {
                case .itemSelected(let item):
                    XCTAssertEqual(item, NASAImageResponse.mock.collection.items[selectedIndex])

                default: break /// Won't be tested in this scenario.
                }
            }
            .store(in: &cancellables)
    }
}
