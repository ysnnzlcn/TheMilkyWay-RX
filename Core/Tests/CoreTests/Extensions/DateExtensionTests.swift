//
//  DateExtensionTests.swift
//  
//
//  Created by Yasin Nazlican on 20.11.2021.
//

import XCTest
@testable import Core

class DateExtensionTests: XCTestCase {

    func test_whenStringGiven_thenCheckOutput() {
        let stabileDate = "2002-03-20T00:00:00Z".toDate() // This is tested in its own.
        XCTAssertNotNil(stabileDate)

        XCTAssertNotNil(stabileDate?.toString(format: "yyyy-MM-dd HH:mm"))
        XCTAssertEqual(stabileDate?.toString(format: "yyyy-MM-dd"), "2002-03-20")
        XCTAssertEqual(stabileDate?.toString(format: "yyyy, MM, dd"), "2002, 03, 20")
        XCTAssertEqual(stabileDate?.toString(format: "yyyy-MMM-dd"), "2002-Mar-20")
        XCTAssertEqual(stabileDate?.toString(format: "yyyy-MM-dd HH:mm:ss"), "2002-03-20 02:00:00")
        XCTAssertEqual(stabileDate?.toString(format: "yyyy-MM-dd HH-mm"), "2002-03-20 02-00")
    }
}
