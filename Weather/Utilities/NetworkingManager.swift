//
//  NetworkingManager.swift
//  Weather
//
//  Created by Артем Хлопцев on 06.04.2022.
//

import Foundation
import Combine
class NetworkingManager {
    enum NetworkingErrors: LocalizedError {
        case badURLResponse(url: URL), unknown
        var errorDescription: String? {
            switch self {
            case .badURLResponse(url: let url):
                return "[🔴] Bad Response from url: \(url)"
            case .unknown: return "[⚠️] Unknown Error Occured"
            }
        }
    }
    
    static func getData(url: URL) -> AnyPublisher<Data, Error> {
        URLSession.shared.dataTaskPublisher(for: url)
            .tryMap({ try handleResponse(url: url, output: $0)})
            .retry(3)
            .eraseToAnyPublisher()
            
    }
    static func handleResponse(url: URL, output: URLSession.DataTaskPublisher.Output) throws -> Data {
        guard let response = output.response as? HTTPURLResponse,
              response.statusCode >= 200 && response.statusCode < 300 else {
                  throw NetworkingErrors.badURLResponse(url: url)
              }
        return output.data
    }
    static func handleCompletion(completion: Subscribers.Completion<Error>) {
        switch completion {
        case .finished:
            break
        case .failure(let error):
            print(error)
        }
    }
}
