//
//  NetworkManager.swift
//  WeatherApp
//
//  Created by Charles Janjgava on 11/2/25.
//

import UIKit

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
    func getData<T: Decodable>(url: String, completion: @escaping(Result<T,Error>)->()) {
        let urlString = url
        let url = URL(string: urlString)!
        let urlRequest = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let error {
                print("API Error: \(error.localizedDescription)")
                completion(.failure(error))
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                print("No Response")
                completion(.failure(NetworkError.noResponse))
                return
            }
            
            guard (200...299).contains(response.statusCode) else {
                print("Wrong status code")
                completion(.failure(NetworkError.wrongStatusCode))
                return
            }
            
            guard let data else {
                print("No data")
                completion(.failure(NetworkError.noDataAvailable))
                return
            }
            
            do {
                let decodedObject = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedObject))
            } catch {
                print("Decoding error: \(error)")
                completion(.failure(NetworkError.decodingError))
            }
        }.resume()
    }
}
