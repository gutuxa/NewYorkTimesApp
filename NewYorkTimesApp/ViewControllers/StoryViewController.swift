//
//  StoryViewController.swift
//  NewYorkTimesApp
//
//  Created by Oksana Tugusheva on 04.05.2021.
//

import UIKit

class StoryViewController: UIViewController {
    
    var story: ArtStory!

    @IBOutlet var sectionLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var imageView: StoryImageView!
    @IBOutlet var abstractTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
}

// MARK: - Private Methods

extension StoryViewController {
    private func configure() {
        sectionLabel.text = story.section?.uppercased()
        titleLabel.text = story.title
        abstractTextView.text = story.abstract
                
        guard let image = getWidestImage() else { return }
        
        imageView.fetchImage(from: image.url ?? "")
    }
    
    private func getWidestImage() -> Media? {
        let images = Dictionary(grouping: story.multimedia, by: { $0.width })
        let sortedImages = images.sorted { ($0.key ?? 0) > ($1.key ?? 0) }

        guard let image = sortedImages.first?.value.first else { return nil }

        return image
    }
}
