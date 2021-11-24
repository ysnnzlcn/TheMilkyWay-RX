//
//  NetworkError.swift
//  
//
//  Created by Yasin Nazlican on 17.11.2021.
//

import Foundation

public struct NetworkErrorResponse: Decodable {

    public let reason: String
}

public enum NetworkError: Error {
    
    case error(Error)
    case serverError
    case internalError(NetworkErrorResponse)

    public var customDescription: String {
        switch self {
        case .error(let error):
            return error.localizedDescription

        case .serverError:
            return "That didn’t work!"

        case .internalError(let response):
            return response.reason
        }
    }

    public static func mock(error reason: String = "Mock Error") -> NetworkError {
        .error(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: reason]))
    }
}

