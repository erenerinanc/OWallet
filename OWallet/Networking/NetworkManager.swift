//
//  NetworkManager.swift
//  OWallet
//
//  Created by Eren Erinanç on 2.10.2023.
//

import Foundation

enum ErrorType: Error {
    case invalidResponse(message: String = "Invalid HTTP URL Response")
    case decodingError(message: String = "Can not decode object")
    case clientError(message: String = "Client Error")
    case serverError(message: String = "Server Error")
}
protocol NetworkableProtocol {
    var decoder: JSONDecoder { get set }
    var session: URLSession { get set }
    func fetch<T: Decodable>(model: T.Type,
                             request: URLRequest) async throws -> T
}

final class NetworkManager: NetworkableProtocol {
    public var decoder: JSONDecoder
    public var session: URLSession
    
    public init(decoder: JSONDecoder,
                session: URLSession
    ) {
        self.decoder = decoder
        self.session = session
    }
    
    public func fetch<T: Decodable>(model: T.Type,
                                    request: URLRequest) async throws -> T {
        
        guard let (data, httpResponse) = try? await session.data(for: request),
              let httpResponse = httpResponse as? HTTPURLResponse else {
            throw ErrorType.invalidResponse()
        }
        // Success
        if 200...299 ~= httpResponse.statusCode {
            do {
                print(request.cURL(pretty: true))
                let jsonString = String(data: data, encoding: .nextstep) ?? ""
                print("""
                      Data Parsed:
                      \(jsonString)
                      """)
                let response = try decoder.decode(model.self, from: data)
                return response
            } catch {
                // Decoding Error
                throw ErrorType.decodingError(message: error.localizedDescription)
            }
        }
        // Client Error
        if 400...500 ~= httpResponse.statusCode {
            print(request.cURL(pretty: true))
            throw ErrorType.clientError()
        }
        print(request.cURL(pretty: true))
        throw ErrorType.serverError()
    }
    
    
}
