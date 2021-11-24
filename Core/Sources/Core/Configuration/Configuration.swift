//
//  Configuration.swift
//  
//
//  Created by Yasin Nazlican on 17.11.2021.
//

import Foundation

public enum Configuration: String {

    // MARK: Cases

    case development
    case staging
    case production

    // MARK: Public Variables

    /// This should be read from file but because of time constraint, i will leave it as it is.
    public static let current: Configuration = .development

    public var baseUrl: URL {
        var urlString = ""

        switch self {
        case .development:
            urlString = "https://images-api.nasa.gov/"

        case .staging:
            urlString = "https://images-api.nasa.gov/"

        case .production:
            urlString = "https://images-api.nasa.gov/"
        }

        guard let url = URL(string: urlString) else {
            fatalError("Please provide a valid base url.")
        }

        return url
    }

    public var bundleId: String {
        Bundle.main.bundleIdentifier ?? ""
    }
}
