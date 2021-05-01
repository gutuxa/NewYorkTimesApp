//
//  ApiManager.swift
//  NetworkApp
//
//  Created by Oksana Tugusheva on 01.05.2021.
//

class ApiManager {
    private let key = "I7dU3n8LI1OKAUDRhAh0MSV2hQqifpom"
    
    var topArtStories: String {
        "https://api.nytimes.com/svc/topstories/v2/arts.json?api-key=\(key)"
    }
    
    static var shared = ApiManager()
    
    private init() {}
}
