//
//  HomeWorker.swift
//  OWallet
//
//  Created by Eren Erinanç on 4.10.2023.
//

import Foundation

protocol HomeWorkingLogic {
    var networkable: NetworkableProtocol { get set }
    func getCoins() async throws -> CoinResponse
}

class HomeWorker: HomeWorkingLogic {
    
    var networkable: NetworkableProtocol
    
    init(networkable: NetworkableProtocol) {
        self.networkable = networkable
    }
    
    func getCoins() async throws -> CoinResponse {
        let request = RequestBuilder.createRequest(method: .get)
        return try await networkable.fetch(model: CoinResponse.self, request: request)
    }
}
