//
//  ImageManager.swift
//  NewYorkTimesApp
//
//  Created by Oksana Tugusheva on 08.05.2021.
//

import Alamofire

class ImageManager {
    static let shared = ImageManager()
    
    private init() {}
    
    func fetchImage(from url: URL, complition: @escaping (Data, URLResponse?) -> Void) {
        AF.request(url)
            .validate()
            .responseData { response in
                switch response.result {
                case .success(let value):
                    complition(value, response.response)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
    }
}
