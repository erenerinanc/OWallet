//  HomeRoutingLogicSpy.swift
//  OWallet
//
//  Created Eren Erinanç on 4.10.2023.

import Foundation
@testable import OWallet

final class HomeRoutingLogicSpy: HomeRoutingLogic, HomeDataPassing {
    var dataStore: HomeDataStore?
    
    var openModalCalled: Bool = false
    var type: ModalType?
    var selectedIndex: Int?
    func openModal(type: ModalType, selectedIndex: Int?) {
        openModalCalled = true
        self.type = type
        self.selectedIndex = selectedIndex
    }
    
    var routeToDetailCalled: Bool = false
    var index: Int?
    func routeToDetail(index: Int) {
        routeToDetailCalled = true
        self.index = index
    }
}

