//
//  NASAServices.swift
//  
//
//  Created by Yasin Nazlican on 17.11.2021.
//

import Foundation
import RxSwift

public protocol NASAServices {

    func searchImages() -> Single<NASAImageResponse>
}
