//
//  ImageLoader.swift
//  OWallet
//
//  Created by Eren Erinanç on 2.10.2023.
//

import Foundation
import UIKit
import Nuke

protocol ImageLoader {
    func load(to imageView: UIImageView, with url: URL)
}

public struct OWalletImageLoader: ImageLoader {
    public init() {}
    func load(to imageView: UIImageView, with url: URL) {
        let request = ImageRequest(urlRequest: URLRequest(url: url),
                                   processors: [ImageProcessors.Resize(size: imageView.bounds.size)],
                                   priority: .high)
        let pipeline = ImagePipeline.shared
        Task { @MainActor in
            do {
                let image = try await pipeline.image(for: request)
                imageView.image = image
            } catch {
                print("Error while loading an image:", String(describing: error))
            }
        }
    }
}
