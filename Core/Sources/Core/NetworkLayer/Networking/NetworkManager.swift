//
//  NetworkManager.swift
//  
//
//  Created by Yasin Nazlican on 17.11.2021.
//

import Foundation
import RxSwift
import RxCocoa

public protocol Requestable: AnyObject {

    var requestTimeout: Float { get }

    func sendRequest<T>(
        type: T.Type,
        target: NetworkTarget
    ) -> Single<T> where T: Decodable
}

public final class NetworkManager: Requestable {

    // MARK: Shared

    public static let shared = NetworkManager()

    // MARK: Public Read-Only

    let disposeBag = DisposeBag()


    public var requestTimeout: Float { 60 }

    // MARK: Public Methods

    public func sendRequest<T: Decodable>(
        type: T.Type,
        target: NetworkTarget
    ) -> Single<T> {

        URLSessionConfiguration.default.timeoutIntervalForRequest = TimeInterval(target.requestTimeout ?? requestTimeout)

        return URLSession.shared
            .rx
            .response(request: makeRequest(from: target))
            .map { (response, data) -> T in
                guard response.isSuccessful else {
                    /// Parse the error response
                    throw NetworkError.internalError(try JSONDecoder().decode(NetworkErrorResponse.self, from: data))
                }

                /// Parse the successful response
                do {
                    return try JSONDecoder().decode(T.self, from: data)
                } catch let error {
                    throw NetworkError.error(error)
                }
            }
            .observe(on: MainScheduler.instance)
            .asSingle()
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
}

fileprivate extension HTTPURLResponse {

    var isSuccessful: Bool {
        (200...299).contains(statusCode)
    }
}
