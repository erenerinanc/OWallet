//
//  RequestBuilder.swift
//  OWallet
//
//  Created by Eren Erinanç on 2.10.2023.
//

import Foundation

enum HTTPMethod: String{
    case get
}

struct RequestBuilder {
    
    static func createRequest(method: HTTPMethod) -> URLRequest {
        var url = AppSettings.baseURL
        
        var urlComponents = URLComponents(url: url,
                                          resolvingAgainstBaseURL: true)
        
        var request = URLRequest(url: (urlComponents?.url!)!,
                                 cachePolicy: .useProtocolCachePolicy,
                                 timeoutInterval: .greatestFiniteMagnitude)
        request.httpMethod = method.rawValue.uppercased()
        return request
    }
}
