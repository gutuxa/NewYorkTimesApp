//
//  StoryViewController.swift
//  NewYorkTimesApp
//
//  Created by Oksana Tugusheva on 04.05.2021.
//

import UIKit

class StoryViewController: UIViewController {
    
    var story: ArtStory?

    @IBOutlet var sectionLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var abstractTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
}

// MARK: - Private Methods

extension StoryViewController {
    private func configure() {
        sectionLabel.text = story?.section?.uppercased()
        titleLabel.text = story?.title
        abstractTextView.text = story?.abstract
        
        let media = getWidestImage()
        
        guard let image = media else { return }
        guard let url = URL(string: image.url ?? "") else { return }
        
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: url) else { return }
            
            DispatchQueue.main.async {
                self.imageView.image = UIImage(data: imageData)
            }
        }
    }
    
    private func getWidestImage() -> Media? {
        let images = Dictionary(grouping: story?.multimedia ?? [], by: { $0.width })
        let sortedImages = images.sorted { ($0.key ?? 0) > ($1.key ?? 0) }

        guard let image = sortedImages.first?.value.first else { return nil }

        return image
    }
}
