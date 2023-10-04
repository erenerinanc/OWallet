//
//  HomeInteractor.swift
//  OWallet
//
//  Created by Eren Erinanç on 4.10.2023.
//

import Foundation

protocol HomeBusinessLogic {
    func fetchCoins()
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
                presenter.presentCoins(coins: coins)
            } catch {
                presenter.presentError(title: "Ups!", message: error.localizedDescription)
            }
            
        }
    }
    
}



