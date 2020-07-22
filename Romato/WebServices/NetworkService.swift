//
//  NetworkService.swift
//  Romato
//
//  Created by Jithin M on 20/07/20.
//  Copyright © 2020 Jithin M. All rights reserved.
//

import Foundation
import Combine

enum NetworkError : LocalizedError {
    case userOffline
    case serverError
    case hostNotFound
    case unknownError
    case invalidUrl
}

class NetworkService {
    
    func fetchFromNetwork(service: WebService) -> AnyPublisher<[Movie], Error> {
        let url = UrlUtility.urlForService(service: service)
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .retry(2)
            .receive(on: RunLoop.main)
            .map {
                $0.data
            }
            .decode(type: [Movie].self, decoder: JSONDecoder())
            .mapError({ error -> NetworkError in
                switch error {
                case URLError.notConnectedToInternet:
                return .userOffline
                case URLError.cannotFindHost:
                return .hostNotFound
                case URLError.badURL:
                return .invalidUrl
                case URLError.badServerResponse:
                return .serverError
                default:
                return .unknownError
                }
            })
            .eraseToAnyPublisher()
    }
}
