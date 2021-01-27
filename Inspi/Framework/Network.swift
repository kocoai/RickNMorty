//
//  Network.swift
//  Inspi
//
//  Created by Kien on 1/25/21.
//

import Foundation
import Combine

struct RESTClient {
    let session: URLSession
    
    func get<T: Decodable>(url: String, headers: [String:String]? = nil, decoder: JSONDecoder = JSONDecoder(), type: T.Type? = nil) -> AnyPublisher<T, Error> {
        guard let url = URL(string: url) else {
            return Fail(error: RESTClientError.invalidURL).eraseToAnyPublisher()
        }
        var request = URLRequest(url: url)
        request.httpMethod = Method.GET.rawValue
        headers?.forEach { key, value in
            request.addValue(value, forHTTPHeaderField: key)
        }
        return perform(request: request, decoder: decoder, type: type)
    }
    
    private func perform<T: Decodable>(request: URLRequest, decoder: JSONDecoder = JSONDecoder(), type: T.Type? = nil) -> AnyPublisher<T, Error> {
        return session
            .dataTaskPublisher(for: request)
            .tryMap { try decoder.decode(T.self, from: $0.data) }
            .eraseToAnyPublisher()
    }
    
    enum Method: String {
        case GET, POST
    }
}

enum RESTClientError: Error {
    case invalidURL
}
