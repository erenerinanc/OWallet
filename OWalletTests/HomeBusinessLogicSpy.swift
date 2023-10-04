//  HomeBusinessLogicSpy.swift
//  OWallet
//
//  Created Eren Erinanç on 4.10.2023.

import Foundation
@testable import OWallet
@testable import SDWebImage

final class HomeBusinessLogicSpy: HomeBusinessLogic {
    var isFetchCoinsCalled: Bool = false
    func fetchCoins() {
        isFetchCoinsCalled = true
    }
    
    var isListOrSortCalled: Bool = false
    var type: ModalType?
    var index: Int?
    func listOrSort(type: ModalType, index: Int) {
        isListOrSortCalled = true
        self.type = type
        self.index = index
    }
}

