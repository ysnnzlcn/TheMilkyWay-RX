//
//  StringExtensionTests.swift
//  
//
//  Created by Yasin Nazlican on 20.11.2021.
//

import XCTest
@testable import Core

class StringExtensionTests: XCTestCase {

    func test_whenStringFormatGiven_thenCheckIfThereIsValidDate() {
        XCTAssertNotNil("2002-03-20".toDate(format: "yyyy-MM-dd"))
        XCTAssertNotNil("2002-03-20 02".toDate(format: "yyyy-MM-dd HH"))
        XCTAssertNotNil("2002-03-20 02:00".toDate(format: "yyyy-MM-dd HH:mm"))
        XCTAssertNotNil("2002-03-20 02:00:00".toDate(format: "yyyy-MM-dd HH:mm:ss"))
        XCTAssertNotNil("20-03-2002".toDate(format: "dd-MM-yyyy"))
        XCTAssertNil("2002-03-20 02:00".toDate(format: "yyyy-MM-dd"))
        XCTAssertNil("2002-03-20 02".toDate(format: "yyyy-MM-dd"))
        XCTAssertNil("2002-03".toDate(format: "yyyy-MM-dd"))
    }
}
