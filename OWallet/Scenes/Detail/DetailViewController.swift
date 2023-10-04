//
//  DetailViewController.swift
//  OWallet
//
//  Created Eren Erinanç on 2.10.2023.

import UIKit

class DetailViewController: BaseViewController {
	var businessModel: DetailBusinesModelProtocol?
    /// current price
    lazy var currentPriceLabel = UILabel().configure {
        $0.font = .systemFont(ofSize: 14, weight: .light)
        $0.textColor = .black
        $0.text = Constants.currentPrice.uppercased()
    }
    lazy var currentValue = UILabel().configure {
        $0.font = .systemFont(ofSize: 18, weight: .bold)
        $0.textColor = .black
    }
    lazy var change = UILabel().configure {
        $0.font = .systemFont(ofSize: 14, weight: .bold)
    }
    lazy var currencyStack = UIStackView(arrangedSubviews: [currentPriceLabel, currentValue, change]).configure {
        $0.alignment = .leading
        $0.axis = .vertical
        $0.spacing = 8
    }
    /// highest price
    lazy var highestLabel = UILabel().configure {
        $0.font = .systemFont(ofSize: 14, weight: .bold)
        $0.textColor = .systemGray
        $0.text = Constants.detailHighest
    }
    lazy var highestValue = UILabel().configure {
        $0.font = .systemFont(ofSize: 14, weight: .bold)
        $0.textColor = .systemGreen
    }
    lazy var highestStack = UIStackView(arrangedSubviews: [highestLabel, highestValue]).configure {
        $0.spacing = 2
    }
    /// lowest price
    lazy var lowestLabel = UILabel().configure {
        $0.font = .systemFont(ofSize: 14, weight: .bold)
        $0.textColor = .systemGray
        $0.text = Constants.detailLowest
    }
    lazy var lowestValue = UILabel().configure {
        $0.font = .systemFont(ofSize: 14, weight: .bold)
        $0.textColor = .systemOrange
    }
    lazy var lowestStack = UIStackView(arrangedSubviews: [lowestLabel, lowestValue]).configure {
        $0.spacing = 2
    }
    /// price high and low
    lazy var priceStack = UIStackView(arrangedSubviews: [highestStack, lowestStack]).configure {
        $0.alignment = .trailing
        $0.spacing = 4
        $0.axis = .vertical
    }
    lazy var imageView = UIImageView().configure {
        $0.snp.makeConstraints { make in
            make.width.equalTo(200)
            make.height.equalTo(300)
        }
        $0.contentMode = .scaleAspectFit
    }
    
    // MARK: View lifecycle
    convenience init(businessModel: DetailBusinesModelProtocol) {
        self.init(nibName: nil, bundle: nil)
        self.businessModel = businessModel
    }

    override public func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        navigationController?.navigationBar.tintColor = .systemPurple
        if let viewModel = businessModel?.getViewModel() {
            configure(with: viewModel)
        }
    }
    
    private func setUpUI() {
        view.backgroundColor = .systemGray6
        let outsideStack = UIStackView(arrangedSubviews: [currencyStack, priceStack])
        outsideStack.alignment = .bottom
        outsideStack.distribution = .fillProportionally
        outsideStack.spacing = 40
        outsideStack.backgroundColor = .white
        
        let padding: CGFloat = 16
        
        let containerView = UIView()
        containerView.layer.cornerRadius = 10
        containerView.backgroundColor = .white
        containerView.addSubview(outsideStack)
        outsideStack.snp.makeConstraints {
            $0.directionalEdges.equalToSuperview().inset(padding)
        }
        view.addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(padding)
            make.leading.trailing.equalToSuperview().inset(padding)
        }
        view.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.top.equalTo(containerView.snp.bottom).offset(padding)
            make.centerX.equalToSuperview()
        }
    }
    
    private func configure(with model: ViewModel) {
        title = model.title
        currentValue.text = model.currentPrice
        change.text = model.change
        model.isProfitMade ? (change.textColor = .systemGreen) : (change.textColor = .systemOrange)
        highestValue.text = model.highestValue
        lowestValue.text = model.lowestValue
        if let url = URL(string: model.iconURL) {
            OWalletImageLoader().load(to: imageView, with: url)
        }
        
    }
}
