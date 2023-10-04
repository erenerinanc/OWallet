//  HomeWorkingLogicSpy.swift
//  OWallet
//
//  Created Eren Erinanç on 4.10.2023.

import Foundation
@testable import OWallet

final class HomeWorkingLogicSpy: HomeWorkingLogic {
    var networkable: NetworkableProtocol
    
    init(networkable: NetworkableProtocol) {
        self.networkable = networkable
    }
    
    var url: URL = Mocks.empty.url
    func getCoins() async throws -> CoinResponse {
        do {
            let data = try Stub.getData(file: url)
            let response = try Stub.parse(json: data, decodable: CoinResponse.self)
            return response
        } catch {
            throw ErrorType.invalidResponse()
        }
    }

}

enum Mocks: String {
    case home
    case empty

    var url: URL {
        let thisSourceFile = URL(fileURLWithPath: #file)
        let thisDirectory = thisSourceFile.deletingLastPathComponent()
        return thisDirectory
            .appendingPathComponent("MockFiles/\(rawValue)")
            .appendingPathExtension("json")
    }
}

class Stub {
    static func getData(file url: URL) throws -> Data {
        try Data(contentsOf: url)
    }
    
    static func parse<T: Decodable>(json: Data, decodable object: T.Type) throws -> T {
        try JSONDecoder().decode(object.self, from: json)
    }
}
