//
//  NASANetworkTarget.swift
//  
//
//  Created by Yasin Nazlican on 17.11.2021.
//

import Foundation

public enum NASANetworkTarget {

    case searchImages(key: String)
}

extension NASANetworkTarget: NetworkTarget {

    public var baseURL: URL {
        Configuration.current.baseUrl
    }

    public var url: URL {
        var path = ""

        switch self {
        case .searchImages:
            path = "search"
        }

        guard let url = URL(string: baseURL.absoluteString + path) else {
            fatalError("Please provide a valid path url.")
        }
        return url
    }

    public var method: HTTPMethod {
        switch self {
        case .searchImages:
            return .get
        }
    }

    public var headers: [String: String]? {
        switch self {
        case .searchImages:
            return nil
        }
    }

    public var body: Data? {
        switch self {
        case .searchImages:
            return nil
        }
    }

    public var queryItems: [URLQueryItem] {
        switch self {
        case .searchImages(let text):
            return [.init(name: "q", value: text)]
        }
    }
}
