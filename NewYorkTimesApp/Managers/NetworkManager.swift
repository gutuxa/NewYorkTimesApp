//
//  NetworkManager.swift
//  NetworkApp
//
//  Created by Oksana Tugusheva on 01.05.2021.
//

import Foundation

class NetworkManager {
    private init() {}
    
    static func fetch(url: URL, closure: @escaping (_ data: Data) -> Void) {
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            guard let data = data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
                        
            closure(data)
            
        }.resume()
    }
}
