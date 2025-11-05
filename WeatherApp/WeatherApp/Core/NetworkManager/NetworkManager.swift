//
//  NetworkManager.swift
//  WeatherApp
//
//  Created by Charles Janjgava on 11/2/25.
//

import Foundation

enum NetworkError: Error {
    case noDataAvailable
    case unableToProcessData
    case decodingError
    case wrongStatusCode
    case noResponse
    
    var localizedDescription: String {
        switch self {
        case .noDataAvailable: return "No data available"
        case .decodingError: return "Decoding error"
        case .wrongStatusCode: return "Wrong status code"
        case .unableToProcessData: return "Unable to process data"
        case .noResponse: return "No response from server"
        }
    }
}

class NetworkManager {
    func getData<T: Decodable>(url: String, completion: @escaping(Result<T, Error>) -> Void) {
        guard let url = URL(string: url) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(NetworkError.noResponse))
                return
            }
            
            guard (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(NetworkError.wrongStatusCode))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.noDataAvailable))
                return
            }
            
            do {
                let decoded = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decoded))
            } catch {
                completion(.failure(NetworkError.decodingError))
            }
        }.resume()
    }
}
