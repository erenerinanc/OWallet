//
//  DetailWorker.swift
//  OWallet
//
//  Created Eren Erinanç on 2.10.2023.

import Foundation

protocol DetailWorkingLogic {
    var networkable: NetworkableProtocol { get set }
}

class DetailWorker: DetailWorkingLogic {
    var networkable: NetworkableProtocol
    
    init(networkable: NetworkableProtocol) {
        self.networkable = networkable
    }
}
