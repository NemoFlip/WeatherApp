//
//  NetworkingManager.swift
//  Weather
//
//  Created by Артем Хлопцев on 06.04.2022.
//

import Foundation

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
    
    static func getData(url: URL) async -> Data? {
        do {
            let (data, response) = try await URLSession.shared.data(from: url, delegate: nil)
            return try handleResponse(url: url, response: response, data: data)
        } catch {
            print(error)
        }
        return nil
    }
    static func handleResponse(url: URL, response: URLResponse, data: Data) throws -> Data {
        guard let response = response as? HTTPURLResponse,
              response.statusCode >= 200 && response.statusCode < 300 else {
                  throw NetworkingErrors.badURLResponse(url: url)
              }
        return data
    }
}
