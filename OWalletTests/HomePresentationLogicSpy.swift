//  HomePresentationLogicSpy.swift
//  OWallet
//
//  Created Eren Erinanç on 4.10.2023.

import Foundation
@testable import OWallet

final class HomePresentationLogicSpy: HomePresentationLogic {
    var isPresentErrorCalled: Bool = false
    var title: String?
    var message: String?
    func presentError(title: String, message: String) {
        self.title = title
        self.message = message
        isPresentErrorCalled = true
    }
    
    var coins: [Coin]?
    var listingType: ListingType?
    var sortingType: SortingType?
    var isPresentCoinsCalled: Bool = false
    func presentCoins(coins: [Coin], listingType: ListingType?, sortingType: SortingType?) {
        self.coins = coins
        self.listingType = listingType
        self.sortingType = sortingType
        isPresentCoinsCalled = true
    }
}

