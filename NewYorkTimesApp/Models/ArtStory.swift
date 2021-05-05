//
//  ArtStory.swift
//  NetworkApp
//
//  Created by Oksana Tugusheva on 01.05.2021.
//

struct ArtStory: Decodable {
    let title: String?
    let abstract: String?
    let section: String?
    let byline: String?
    let multimedia: [Media]?
    
    init(data: [String: Any]) {
        title = data["title"] as? String
        abstract = data["abstract"] as? String
        section = data["section"] as? String
        byline = data["byline"] as? String
        multimedia = Media.getMedia(from: data["multimedia"])
    }
    
    static func getStories(from value: Any) -> [ArtStory] {
        guard let response = value as? [String: Any] else { return [] }
        guard let stories = response["results"] as? [[String: Any]] else { return [] }
        return stories.compactMap { ArtStory(data: $0) }
    }
}

struct Media: Decodable {
    let url: String?
    let width: Int?
    let height: Int?
    
    init(data: [String: Any]) {
        url = data["url"] as? String
        width = data["width"] as? Int
        height = data["height"] as? Int
    }
    
    static func getMedia(from value: Any?) -> [Media] {
        guard let value = value as? [[String: Any]] else { return [] }
        return value.compactMap { Media(data: $0) }
    }
}
