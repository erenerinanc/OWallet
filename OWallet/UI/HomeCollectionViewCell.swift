//
//  HomeCollectionViewCell.swift
//  OWallet
//
//  Created by Eren Erinanç on 2.10.2023.
//

import Foundation
import UIKit
import SnapKit

 class HomeCollectionViewCell: UICollectionViewCell {
    public lazy var coinImageView = UIImageView().configure {
        $0.snp.makeConstraints { make in
            make.width.height.equalTo(25)
        }
        $0.contentMode = .scaleAspectFit
    }
    /// coin
    lazy var coinSymbol = UILabel().configure {
        $0.textColor = .systemGray
        $0.font = .systemFont(ofSize: 12)
    }
    lazy var coinName = UILabel().configure {
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 14)
    }
    private lazy var coinStack = UIStackView(arrangedSubviews: [coinSymbol, coinName]).configure {
        $0.axis = .vertical
        $0.alignment = .leading
        $0.spacing = 4
    }
    /// currency
    lazy var price = UILabel().configure {
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 14)
    }
    lazy var change = UILabel().configure {
        $0.font = .systemFont(ofSize: 10)
    }
    private lazy var currencyStack = UIStackView(arrangedSubviews: [price, change]).configure {
        $0.axis = .vertical
        $0.alignment = .trailing
        $0.spacing = 4
    }
    /// outside stack
     private lazy var outsideStack = UIStackView(arrangedSubviews: [coinStack, currencyStack]).configure {
         $0.alignment = .center
         $0.distribution = .fillProportionally
     }
    // MARK: Object Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        contentView.layer.cornerRadius = 10
 
        let containerView = UIView()
        contentView.backgroundColor = .white
        containerView.backgroundColor = .white
        containerView.addSubview(coinImageView)
        coinImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        containerView.addSubview(outsideStack)
        outsideStack.snp.makeConstraints { make in
            make.leading.equalTo(coinImageView.snp.trailing).offset(8)
            make.trailing.equalToSuperview().inset(8)
            make.centerY.equalToSuperview()
        }
        
        contentView.addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.directionalEdges.equalToSuperview().inset(8)
            make.center.equalToSuperview()
        }
    }
    
    func set(viewModel: ViewModel) {
        if let url = URL(string: viewModel.coinImageURL) {
            OWalletImageLoader().load(to: coinImageView, with: url)
        }
        coinSymbol.text = viewModel.coinSymbol
        coinName.text = viewModel.coinName
        price.text = viewModel.value
        change.text = viewModel.change
        change.textColor = viewModel.isProfited ? .systemGreen : .systemOrange
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        coinImageView.image = nil
        coinSymbol.text = ""
        coinName.text = ""
        price.text = ""
        change.text = ""
    }
}

extension HomeCollectionViewCell {
    public struct ViewModel {
        let coinImageURL: String
        let coinSymbol: String
        let coinName: String
        let value: String
        let valueDouble: Double
        let change: String
        let isProfited: Bool
    }
}
