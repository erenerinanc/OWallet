//
//  UICollectionView+Ext.swift
//  OWallet
//
//  Created by Eren Erinanç on 2.10.2023.
//

import Foundation
import UIKit

extension UICollectionView {
    static func makeVerticalLayout() -> UICollectionViewCompositionalLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let padding: CGFloat = 16
        item.contentInsets = .init(top: 0, leading: padding/2, bottom: padding, trailing: padding/2)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .absolute(80))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                     subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        return UICollectionViewCompositionalLayout(section: section)
    }
}
