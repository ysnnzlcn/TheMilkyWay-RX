//
//  ImageDetailsViewModelTests.swift
//  
//
//  Created by Yasin Nazlican on 21.11.2021.
//

import Core
import Home
import XCTest
import RxSwift
import RxCocoa

final class ImageDetailsViewModelTests: XCTestCase {

    private var sut: ImageDetailsViewModel!
    private var disposeBag = DisposeBag()
    private var selectedImage = NASAImageResponse.mock.collection.items.first!

    override func setUp() {
        super.setUp()
        sut = ImageDetailsViewModel(
            service: MockNASAServices(),
            imageModel: selectedImage
        )
    }

    override func tearDown() {
        disposeBag = DisposeBag()
        sut = nil
        super.tearDown()
    }

    func test_whenDidLoad_thenCheckForStateAndDataSource() {
        // then
        XCTAssertEqual(sut.imageTitle, selectedImage.info.first!.title)

        /// Expected item count tests
        let items = sut.items.value
        XCTAssertEqual(items.count, 3)

        // Cell type check tests
        XCTAssertTrue(areImageDetailsCellTypeEqual(items[0], .imageHeaderCell(nil)))
        XCTAssertTrue(areImageDetailsCellTypeEqual(items[1], .plainTextCell(.init())))
        XCTAssertTrue(areImageDetailsCellTypeEqual(items[2], .plainTextCell(.init())))
    }

    private func areImageDetailsCellTypeEqual(_ first: ImageDetailsCellType, _ second: ImageDetailsCellType) -> Bool {
        switch (first, second) {
        case (.imageHeaderCell, .imageHeaderCell), (.plainTextCell, .plainTextCell):
            return true

        default:
            return false
        }
    }
}
