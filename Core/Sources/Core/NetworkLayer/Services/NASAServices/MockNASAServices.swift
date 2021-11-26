//
//  MockNASAServices.swift
//  
//
//  Created by Yasin Nazlican on 17.11.2021.
//

import Foundation
import RxSwift

public class MockNASAServices: NASAServices {

    // MARK: Life-Cycle

    public init() { }

    // MARK: Protocol Conformance

    public var searchImagesCallsCount: Int = 0
    public var searchImagesResult: Single<NASAImageResponse> = Single.just(NASAImageResponse.mock)

    public func searchImages() -> Single<NASAImageResponse> {
        searchImagesCallsCount += 1
        return searchImagesResult
    }
}
