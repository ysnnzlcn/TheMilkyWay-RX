//
//  HomeViewModelTests.swift
//  
//
//  Created by Yasin Nazlican on 20.11.2021.
//

import Core
import Home
import RxSwift
import RxCocoa
import XCTest

final class HomeViewModelTests: XCTestCase {

    private var sut: HomeViewModel!
    private var mockNasaService: MockNASAServices!
    private var disposeBag = DisposeBag()

    override func setUp() {
        super.setUp()
        mockNasaService = MockNASAServices()
        sut = HomeViewModel(service: mockNasaService)
    }

    override func tearDown() {
        disposeBag = DisposeBag()
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
        mockNasaService.searchImagesResult = Single.just(NASAImageResponse.mock)
        var loaderCallCount = 0

        sut.items
            .subscribe {
                XCTAssertEqual($0, NASAImageResponse.mock.collection.items)
            }
            .disposed(by: disposeBag)

        sut.state
            .subscribe(onNext: { state in
                switch state {
                case .toggleLoading:
                    loaderCallCount += 1

                default: break /// Won't be tested in this scenario.
                }
            })
            .disposed(by: disposeBag)

        // when
        sut.didLoad()

        // then
        XCTAssertEqual(mockNasaService.searchImagesCallsCount, 1)
        XCTAssertEqual(loaderCallCount, 2)
    }

    func test_givenServiceCallFails_shouldUpdateStateWithError() {
        // given
        let errorMessage = "Mock Error"
        mockNasaService.searchImagesResult = .error(NetworkError.mock(error: errorMessage))

        // when
        sut.didLoad()

        // then
        XCTAssertEqual(mockNasaService.searchImagesCallsCount, 1)
        sut.items
            .map { items -> [NASAImage] in
                items.map { $0 }
            }
            .subscribe {
                XCTAssertEqual($0, NASAImageResponse.mock.collection.items)
            }
            .disposed(by: disposeBag)

        sut.state
            .subscribe(onNext: { state in
                switch state {
                case .error(let error):
                    XCTAssertEqual(error, errorMessage)

                default: break /// Won't be tested in this scenario.
                }
            })
            .disposed(by: disposeBag)
    }
}
