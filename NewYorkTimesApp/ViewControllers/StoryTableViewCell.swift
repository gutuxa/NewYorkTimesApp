//
//  StoryTableViewCell.swift
//  NetworkApp
//
//  Created by Oksana Tugusheva on 01.05.2021.
//

import UIKit

class StoryTableViewCell: UITableViewCell {

    @IBOutlet var sectionLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var abstractLabel: UILabel!
    @IBOutlet var bylineLabel: UILabel!
    @IBOutlet var thumbnailImage: UIImageView!
    
    func configure (with story: ArtStory) {
        sectionLabel.text = story.section?.uppercased()
        titleLabel.text = story.title
        abstractLabel.text = story.abstract
        bylineLabel.text = story.byline
        
        let thumbnails = Dictionary(grouping: story.multimedia, by: { $0.width })
        
        guard let thumbnail = thumbnails[75]?.first else { return }
        guard let url = URL(string: thumbnail.url ?? "") else { return }
        
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: url) else { return }
            
            DispatchQueue.main.async {
                self.thumbnailImage.image = UIImage(data: imageData)
            }
        }
    }
}
