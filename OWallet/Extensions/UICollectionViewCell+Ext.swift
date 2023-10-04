//
//  UICollectionViewCell+Ext.swift
//  OWallet
//
//  Created by Eren Erinanç on 2.10.2023.
//

import Foundation
import UIKit

public extension UICollectionViewCell {
    static var reuseId: String {
        return String(describing: Self.self)
    }
}
