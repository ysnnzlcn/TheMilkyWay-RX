//
//  MockNASAServices.swift
//  
//
//  Created by Yasin Nazlican on 17.11.2021.
//

import Combine
import Foundation

public class MockNASAServices: NASAServices {

    // MARK: Life-Cycle

    public init() { }

    // MARK: Protocol Conformance

    public var searchImagesCallsCount: Int = 0
    public var searchImagesResult: Result<NASAImageResponse, NetworkError> = .success(NASAImageResponse.mock)

    public func searchImages() -> AnyPublisher<NASAImageResponse, NetworkError> {
        searchImagesCallsCount += 1
        return searchImagesResult.publisher.eraseToAnyPublisher()
    }
}
