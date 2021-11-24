//
//  RestNASAServices.swift
//  
//
//  Created by Yasin Nazlican on 17.11.2021.
//

import Foundation
import Combine

public class RestNASAServices: NASAServices {

    // MARK: Private Variables

    private let networkManager: Requestable

    // MARK: Life-Cycle

    public init(networkManager: Requestable = NetworkManager.shared) {
        self.networkManager = networkManager
    }

    // MARK: Protocol Conformance

    public func searchImages() -> AnyPublisher<NASAImageResponse, NetworkError> {
        let target: NASANetworkTarget = .searchImages(key: "\"\"") /// "" means search for all.
        return networkManager.sendRequest(type: NASAImageResponse.self, target: target)
    }
}
