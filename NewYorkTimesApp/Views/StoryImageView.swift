//
//  StoryImageView.swift
//  NewYorkTimesApp
//
//  Created by Oksana Tugusheva on 08.05.2021.
//

import UIKit

class StoryImageView: UIImageView {
    func fetchImage(from url: String) {
        guard let imageUrl = URL(string: url) else {
            image = #imageLiteral(resourceName: "picture")
            return
        }
        
        if let cachedImage = getCachedImage(from: imageUrl) {
            image = cachedImage
            return
        }
        
        ImageManager.shared.fetchImage(from: imageUrl) { (imageData, response) in
            self.image = UIImage(data: imageData)
            guard let response = response else { return }
            self.saveImageToCache(imageData, response)
        }
    }
}

// MARK: - Private Methods
extension StoryImageView {
    private func getCachedImage(from url: URL) -> UIImage? {
        let request = URLRequest(url: url)
        if let cachedResponse = URLCache.shared.cachedResponse(for: request) {
            return UIImage(data: cachedResponse.data)
        }
        return nil
    }
    
    private func saveImageToCache(_ data: Data, _ response: URLResponse) {
        guard let url = response.url else { return }
        let request = URLRequest(url: url)
        let cachedResponse = CachedURLResponse(response: response, data: data)
        URLCache.shared.storeCachedResponse(cachedResponse, for: request)
    }
}
