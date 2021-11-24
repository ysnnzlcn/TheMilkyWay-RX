//
//  ImageDetailsViewModelTests.swift
//  
//
//  Created by Yasin Nazlican on 21.11.2021.
//

import Combine
import Core
import Home
import XCTest

final class ImageDetailsViewModelTests: XCTestCase {

    private var sut: ImageDetailsViewModel!
    private var cancellable: AnyCancellable?
    private var selectedImage = NASAImageResponse.mock.collection.items.first!

    override func setUp() {
        super.setUp()
        sut = ImageDetailsViewModel(
            service: MockNASAServices(),
            imageModel: selectedImage
        )
    }

    override func tearDown() {
        cancellable?.cancel()
        cancellable = nil
        sut = nil
        super.tearDown()
    }

    func test_whenDidLoad_thenCheckForStateAndDataSource() {
        // when
        sut.didLoad()

        // then
        XCTAssertEqual(sut.imageTitle, selectedImage.info.first!.title)

        cancellable = sut.$items
            .receive(on: RunLoop.main)
            .sink(receiveValue: { items in
                /// Expected item count tests
                XCTAssertEqual(items.count, 3)

                // Cell type check tests
                XCTAssertEqual(items[0].cell, .imageHeaderCell(nil))
                XCTAssertEqual(items[1].cell, .plainTextCell(.init()))
                XCTAssertEqual(items[2].cell, .plainTextCell(.init()))
            })
    }
}
