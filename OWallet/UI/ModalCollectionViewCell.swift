//
//  ModalCollectionViewCell.swift
//  OWallet
//
//  Created by Eren Erinanç on 4.10.2023.
//

import Foundation
import UIKit

class ModalCollectionViewCell: UICollectionViewCell {
    lazy var label = UILabel().configure {
        $0.font = .systemFont(ofSize: 12, weight: .bold)
        $0.textColor = .black
    }
    
    var isSelectionMade: Bool = false {
        didSet {
            updateSelectedColors()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        backgroundColor = .white
        layer.cornerRadius = 10
        layer.masksToBounds = true
        contentView.addSubview(label)
        label.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    func setTitle(text: String) {
        self.label.text = text
    }
    
    private func updateSelectedColors() {
        if isSelectionMade {
            backgroundColor = .systemPink.withAlphaComponent(0.3)
            layer.borderWidth = 1
            layer.borderColor = UIColor.white.cgColor
        } else {
            backgroundColor = .white
            layer.borderWidth = 0
            layer.borderColor = nil
        }
   
    }
}
