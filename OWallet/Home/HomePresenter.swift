//
//  HomePresenter.swift
//  OWallet
//
//  Created by Eren Erinanç on 4.10.2023.
//

protocol HomePresentationLogic: AnyObject {
    func presentCoins(coins: [Coin])
    func presentError(title: String, message: String)
}

class HomePresenter: HomePresentationLogic {
    
    weak var viewController: HomeDisplayLogic?
    
    func presentCoins(coins: [Coin]) {
        if let cellModels = getCellModels(from: coins) {
            let viewModel = Home.ViewModel(items: cellModels)
            viewController?.displayCoins(viewModel: viewModel)
        }
    }
    
    private func getCellModels(from coins: [Coin]) -> [HomeCollectionViewCell.ViewModel]? {

        let cellModels = coins.compactMap {
            var price = ""
            var change = ""
            var isProfited = false
            
            if let priceDouble = $0.price?.convertToDouble(),
               let priceString = priceDouble.convertToTwoDecimalString() {
                price = priceString
            }
            
            if let changeDouble = $0.change?.convertToDouble(),
               let changeString = changeDouble.convertToTwoDecimalString()
            {
                if changeDouble >= 0 {
                    isProfited = true
                } else {
                    isProfited = false
                }
                change = changeString
            }
            
            return HomeCollectionViewCell.ViewModel(coinImageURL: $0.iconURL ?? "",
                                                    coinSymbol: $0.symbol ?? "",
                                                    coinName: $0.name ?? "",
                                                    price: price,
                                                    change: change,
                                                    isProfited: isProfited)
        }
        
        return cellModels
    }
    
    func presentError(title: String, message: String) {
        viewController?.displayError(title: title, message: message)
    }
}
