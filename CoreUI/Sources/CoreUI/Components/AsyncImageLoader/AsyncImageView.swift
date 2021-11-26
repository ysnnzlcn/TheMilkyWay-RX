//
//  AsyncImageView.swift
//  
//
//  Created by Yasin Nazlican on 18.11.2021.
//

import UIKit
import RxSwift
import RxCocoa

public class AsyncImageView: UIImageView {

    // MARK: Private Variables

    private var disposeBag = DisposeBag()

    // MARK: Public Variables

    public private(set) var isLoading = false

    // MARK: Public Methods

    public func load(url: URL, cache: TemporaryImageCache) {
        /// Check if it is currently loading and image.
        guard !isLoading else { return }

        /// Get it from the cache if its available.
        if let image = cache[url] {
            self.image = image
            return
        }

        /// Send request to get image.
        onStart()
        URLSession.shared
            .rx
            .response(request: URLRequest(url: url))
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] (_, data) in
                let image = UIImage(data: data)
                self?.image = image
                if let image = image {
                    cache[url] = image
                }
            }, onCompleted: { [weak self] in
                self?.onFinish()
            })
            .disposed(by: disposeBag)
    }

    // MARK: Private Methods

    private func onStart() {
        isLoading = true
    }

    private func onFinish() {
        isLoading = false
    }
}
