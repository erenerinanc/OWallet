//
//  HomeInteractor.swift
//  OWallet
//
//  Created by Eren Erinanç on 4.10.2023.
//

import Foundation

protocol HomeBusinessLogic {
    func fetchCoins()
    func listOrSort(type: ModalType, index: Int) 
}

protocol HomeDataStore: AnyObject {
    var coins: [Coin]? { get set }
}

class HomeInteractor: HomeBusinessLogic,
                                                 HomeDataStore {
    
    var presenter: HomePresentationLogic
    var worker: HomeWorkingLogic
    var coins: [Coin]?
    
    init(presenter: HomePresentationLogic,
         worker: HomeWorkingLogic) {
        self.presenter = presenter
        self.worker = worker
    }
    
    func fetchCoins() {
        Task { @MainActor in
            do {
                let response = try await worker.getCoins()
                self.coins = response.data?.coins
                guard let coins = coins else { return }
                presenter.presentCoins(coins: coins, listingType: .price, sortingType: nil)
            } catch {
                presenter.presentError(title: "Ups!", message: error.localizedDescription)
            }
            
        }
    }
    
    func listOrSort(type: ModalType, index: Int) {
        guard let coins = self.coins else { return }
        switch type {
        case .listing(let items):
            let selection = items[index]
            presenter.presentCoins(coins: coins, listingType: selection, sortingType: nil)
            
        case .sorting(let items):
            let selection = items[index]
            presenter.presentCoins(coins: coins, listingType: nil, sortingType: selection)
        }
    }
    
}



