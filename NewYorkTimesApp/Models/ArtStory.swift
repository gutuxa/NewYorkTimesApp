//
//  ArtStory.swift
//  NetworkApp
//
//  Created by Oksana Tugusheva on 01.05.2021.
//

struct ApiResponse: Decodable {
    let section:  String?
    let results: [ArtStory]?
}

struct ArtStory: Decodable {
    let title: String?
    let abstract: String?
    let section: String?
    let byline: String?
    let multimedia: [Media]
}

struct Media: Decodable {
    let url: String?
    let width: Int?
    let height: Int?
}
