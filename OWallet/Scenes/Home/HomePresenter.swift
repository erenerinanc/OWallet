//
//  HomePresenter.swift
//  OWallet
//
//  Created by Eren Erinanç on 4.10.2023.
//

enum ImageFormat: String {
    case svg = ".svg"
    case png = ".png"
}

protocol HomePresentationLogic: AnyObject {
    func presentCoins(coins: [Coin], listingType: ListingType?, sortingType: SortingType?)
    func presentError(title: String, message: String)
}

class HomePresenter: HomePresentationLogic {
    
    weak var viewController: HomeDisplayLogic?
    
    func presentCoins(coins: [Coin],
                      listingType: ListingType?,
                      sortingType: SortingType?) {
        if let cellModels = getCellModels(from: coins, listingType: listingType, sortingType: sortingType) {
            let viewModel = Home.ViewModel(items: cellModels)
            viewController?.displayCoins(viewModel: viewModel)
        }
    }
    
    private func getCellModels(from coins: [Coin],
                               listingType: ListingType?,
                               sortingType: SortingType?) -> [HomeCollectionViewCell.ViewModel]? {

        let cellModels = coins.compactMap {
            var change = ""
            var isProfited = false
            var iconURL = ""
    
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
            
            if let icon = $0.iconURL {
                if icon.hasSuffix(ImageFormat.svg.rawValue) {
                    iconURL = icon.replacingOccurrences(of: ImageFormat.svg.rawValue, with: ImageFormat.png.rawValue)
                } else if !icon.hasSuffix(ImageFormat.png.rawValue) && !(icon.hasSuffix(ImageFormat.svg.rawValue)) {
                    iconURL = icon + ImageFormat.png.rawValue
                } else {
                    iconURL = icon
                }
            }
            
            let (value, valueDouble) = getValue(coin: $0, listingType: listingType ?? .price, sortingType: sortingType)
        
            return HomeCollectionViewCell.ViewModel(coinImageURL: iconURL,
                                                    coinSymbol: $0.symbol ?? "",
                                                    coinName: $0.name ?? "",
                                                    value: value,
                                                    valueDouble: valueDouble,
                                                    change: change,
                                                    isProfited: isProfited)
        }
        switch sortingType {
        case .highest:
            return cellModels.sorted { $0.valueDouble > $1.valueDouble }
        case .lowest:
            return cellModels.sorted { $0.valueDouble < $1.valueDouble }
        default:
            break
        }
        return cellModels
    }
    
    private func getValue(coin: Coin, listingType: ListingType, sortingType: SortingType?) -> (String, Double) {
        var value = ""
        var valueDouble = 0.0
        switch listingType {
        case .volume24h:
            if let volumeDouble = coin.the24HVolume?.convertToDouble(),
               let volumeString = volumeDouble.convertToTwoDecimalString() {
                value = volumeString
                valueDouble = volumeDouble
            }
        case .marketCap:
            if let marketDouble = coin.marketCap?.convertToDouble(),
               let marketString = marketDouble.convertToTwoDecimalString() {
                value = marketString
                valueDouble = marketDouble
            }
        case .price:
            if let priceDouble = coin.price?.convertToDouble(),
               let priceString = priceDouble.convertToTwoDecimalString() {
                value = priceString
                valueDouble = priceDouble
            }
        }

        return (value, valueDouble)
    }
    func presentError(title: String, message: String) {
        viewController?.displayError(title: title, message: message)
    }
}
