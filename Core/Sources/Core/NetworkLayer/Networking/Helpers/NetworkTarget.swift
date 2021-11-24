//
//  NetworkTarget.swift
//  
//
//  Created by Yasin Nazlican on 17.11.2021.
//

import Foundation

public protocol NetworkTarget {

    /// The target's base `URL`.
    var baseURL: URL { get }

    /// The path to be appended to `baseURL` to form the full `URL`.
    var url: URL { get }

    /// To set timeout for each request.
    var requestTimeout: Float? { get }

    /// The HTTP method used in the request.
    var method: HTTPMethod { get }

    /// The headers to be used in the request.
    var headers: [String: String]? { get }

    /// The body to be used in the target.
    var body: Data? { get }

    /// Query items to be used in request.
    var queryItems: [URLQueryItem] { get }
}

extension NetworkTarget {

    /// Set our timeout to default for all at the beginning.
    public var requestTimeout: Float? { nil }
}
