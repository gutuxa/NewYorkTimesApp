//
//  NetworkManager.swift
//  NetworkApp
//
//  Created by Oksana Tugusheva on 01.05.2021.
//

import Foundation

enum NetworkError: Error {
    case errorResponse(message: String)
    case badResponse(message: String)
}

class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetch(url: String, handler: @escaping (Result<Data, NetworkError>) -> Void) {
        guard let url = URL(string: url) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                handler(.failure(.errorResponse(message: error.localizedDescription)))
                return
            }
            
            guard let data = data, let response = response as? HTTPURLResponse else {
                handler(.failure(.badResponse(message: "No data received")))
                return
            }
            
            guard (200...209).contains(response.statusCode) else {
                handler(.failure(.badResponse(message: "Server respond with status \(response.statusCode)")))
                return
            }

            handler(.success(data))
            
        }.resume()
    }
}
