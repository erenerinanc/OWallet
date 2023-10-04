//  HomeDisplayLogicSpy.swift
//  OWallet
//
//  Created Eren Erinanç on 4.10.2023.

import Foundation
@testable import OWallet

final class HomeDisplayLogicSpy: HomeDisplayLogic {
    var displayErrorCalled: Bool = false
    var title: String?
    var message: String?
    func displayError(title: String, message: String) {
        self.title = title
        self.message = message
    }
    
    var viewModel: Home.ViewModel?
    var isDisplayCoinsCalled: Bool = false
    func displayCoins(viewModel: Home.ViewModel) {
        self.viewModel = viewModel
        isDisplayCoinsCalled = true
    }
}

