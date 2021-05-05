//
//  ApiManager.swift
//  NetworkApp
//
//  Created by Oksana Tugusheva on 01.05.2021.
//

class ApiManager {
    private let key = "hEhLoK1qBW30pi8oE9CKvzD0BNvV2rIL"
    
    var topArtStories: String {
        "https://api.nytimes.com/svc/topstories/v2/arts.json?api-key=\(key)"
    }
    
    static let shared = ApiManager()
    
    private init() {}
}
