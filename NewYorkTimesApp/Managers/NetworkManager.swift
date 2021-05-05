//
//  NetworkManager.swift
//  NetworkApp
//
//  Created by Oksana Tugusheva on 01.05.2021.
//

import Alamofire

class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetch(url: String, handler: @escaping (Result<Any, AFError>) -> Void) {
        AF.request(url)
            .validate()
            .responseJSON  { handler($0.result) }
    }
}
