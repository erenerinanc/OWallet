//
//  ImageLoader.swift
//  OWallet
//
//  Created by Eren Erinanç on 2.10.2023.
//

import Foundation
import UIKit
import SDWebImage

protocol ImageLoader {
    func load(to imageView: UIImageView, with url: URL)
}

public struct OWalletImageLoader: ImageLoader {
    public init() {}

    func load(to imageView: UIImageView, with url: URL) {
        imageView.sd_setImage(with: url)
    }
}
