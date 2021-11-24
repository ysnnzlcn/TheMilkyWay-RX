//
//  TemporaryImageCacheTests.swift
//  
//
//  Created by Yasin Nazlican on 20.11.2021.
//

import CoreUI
import XCTest

class TemporaryImageCacheTests: XCTestCase {

    func test_whenURLGivenOrEmpty_thenCheckTheOutput() {
        let cache = TemporaryImageCache()
        let dummyURL = URL(string: "www.google.com")!

        XCTAssertNil(cache[dummyURL])
        cache[dummyURL] = UIImage()
        XCTAssertNotNil(cache[dummyURL])
        cache[dummyURL] = nil
        XCTAssertNil(cache[dummyURL])
    }
}
