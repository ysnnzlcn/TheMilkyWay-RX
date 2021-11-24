//
//  AsyncImageView.swift
//  
//
//  Created by Yasin Nazlican on 18.11.2021.
//

import Combine
import UIKit

public class AsyncImageView: UIImageView {

    // MARK: Private Variables

    private var cancellable: AnyCancellable?

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
        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map { UIImage(data: $0.data) }
            .replaceError(with: nil)
            .handleEvents(
                receiveSubscription: { [weak self] _ in self?.onStart() },
                receiveOutput: { cache[url] = $0 },
                receiveCompletion: { [weak self] _ in self?.onFinish() },
                receiveCancel: { [weak self] in self?.onFinish() }
            )
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in self?.image = $0 }
    }

    // MARK: Private Methods

    private func onStart() {
        isLoading = true
    }

    private func onFinish() {
        isLoading = false
    }

    private func cancel() {
        cancellable?.cancel()
    }

    deinit {
        cancel()
    }
}
