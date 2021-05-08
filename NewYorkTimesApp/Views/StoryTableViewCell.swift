//
//  StoryTableViewCell.swift
//  NetworkApp
//
//  Created by Oksana Tugusheva on 01.05.2021.
//

import UIKit

class StoryTableViewCell: UITableViewCell {
    
    private let thumbnailWidth = 75

    @IBOutlet var sectionLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var abstractLabel: UILabel!
    @IBOutlet var bylineLabel: UILabel!
    @IBOutlet var thumbnailImage: StoryImageView!
    
    func configure (with story: ArtStory) {
        sectionLabel.text = story.section?.uppercased()
        titleLabel.text = story.title
        abstractLabel.text = story.abstract
        bylineLabel.text = story.byline
        
        let thumbnails = Dictionary(grouping: story.multimedia, by: { $0.width })
        guard let thumbnailUrl = thumbnails[thumbnailWidth]?.first else { return }
        
        thumbnailImage.fetchImage(from: thumbnailUrl.url ?? "")
    }
}
