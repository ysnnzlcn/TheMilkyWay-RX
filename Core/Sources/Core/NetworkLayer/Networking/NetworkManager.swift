//
//  NetworkManager.swift
//  
//
//  Created by Yasin Nazlican on 17.11.2021.
//

import Foundation
import Combine

public protocol Requestable: AnyObject {

    var requestTimeout: Float { get }

    func sendRequest<T>(
        type: T.Type,
        target: NetworkTarget
    ) -> AnyPublisher<T, NetworkError> where T: Decodable
}

public final class NetworkManager: Requestable {

    // MARK: Shared

    public static let shared = NetworkManager()

    // MARK: Public Read-Only

    public var requestTimeout: Float { 60 }

    // MARK: Public Methods

    public func sendRequest<T: Decodable>(
        type: T.Type,
        target: NetworkTarget
    ) -> AnyPublisher<T, NetworkError> {

        URLSessionConfiguration.default.timeoutIntervalForRequest = TimeInterval(target.requestTimeout ?? requestTimeout)

        return URLSession.shared
            .dataTaskPublisher(for: makeRequest(from: target))
            .mapError { NetworkError.error($0) }
            .flatMap({ [weak self] result -> AnyPublisher<T, NetworkError> in
                guard let self = self, let urlResponse = result.response as? HTTPURLResponse else {
                    return Fail(error: .serverError).eraseToAnyPublisher()
                }

                if urlResponse.isSuccessful {
                    return self.decode(type: T.self, result.data)
                } else {
                    return self.decode(type: NetworkErrorResponse.self, result.data)
                        .flatMap({ error in
                            Fail(error: .internalError(error)).eraseToAnyPublisher()
                        })
                        .eraseToAnyPublisher()
                }
            })
            .eraseToAnyPublisher()
    }

    // MARK: Private Methods

    private func makeRequest(from target: NetworkTarget) -> URLRequest {
        var components = URLComponents(string: target.url.absoluteString)
        components?.queryItems = target.queryItems

        guard let url = components?.url else { fatalError("Please provide a valid path url.") }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = target.method.rawValue
        urlRequest.allHTTPHeaderFields = target.headers ?? [:]
        urlRequest.httpBody = target.body
        return urlRequest
    }

    private func decode<T: Decodable>(type: T.Type, _ data: Data) -> AnyPublisher<T, NetworkError> {
        return Just(data)
            .decode(type: type, decoder: JSONDecoder())
            .mapError { NetworkError.error($0) }
            .eraseToAnyPublisher()
    }
}

fileprivate extension HTTPURLResponse {

    var isSuccessful: Bool {
        (200...299).contains(statusCode)
    }
}
