//
//  DetailViewModel.swift
//  OWallet
//
//  Created Eren Erinanç on 2.10.2023.

protocol DetailBusinesModelProtocol  {
    var coin: Coin { get set }
    func getViewModel() -> ViewModel
}

class DetailBusinessModel: DetailBusinesModelProtocol {
    var coin: Coin
    
    init(coin: Coin){
        self.coin = coin
    }
    
    func getViewModel() -> ViewModel {
        var sparkDoubleArr: [Double] = []
        coin.sparkline?.forEach({ string in
            if let doubleValue = string.convertToDouble() {
                sparkDoubleArr.append(doubleValue)
            }
        })
        
        var change = Constants.dolar
        var isProfited = false
        var iconURL = ""
        
        if let changeDouble = coin.change?.convertToDouble(),
           let changeString = changeDouble.convertToTwoDecimalString()
        {
            if changeDouble >= 0 {
                isProfited = true
            } else {
                isProfited = false
            }
            change += changeString
        }
        
        if let icon = coin.iconURL {
            iconURL = icon.formatIconURL()
        }
        
        let lowest = sparkDoubleArr.sorted { $0 < $1 }
        let highest = sparkDoubleArr.sorted { $1 < $0 }
        let model = ViewModel(iconURL: iconURL,
                              title: coin.name ?? "",
                              currentPrice: Constants.dolar + (coin.price?.convertToDouble()?.convertToTwoDecimalString() ?? ""),
                              lowestValue: Constants.dolar + (lowest.first?.convertToTwoDecimalString() ?? ""),
                              highestValue: Constants.dolar + (highest.first?.convertToTwoDecimalString() ?? ""),
                              change: change,
                              isProfitMade: isProfited)
        return model
    }
}

struct ViewModel {
    let iconURL: String
    let title: String
    let currentPrice: String
    let lowestValue: String
    let highestValue: String
    let change: String
    let isProfitMade: Bool
}
