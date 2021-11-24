//
//  NASAServices.swift
//  
//
//  Created by Yasin Nazlican on 17.11.2021.
//

import Foundation
import Combine

public protocol NASAServices {

    func searchImages() -> AnyPublisher<NASAImageResponse, NetworkError>
}
