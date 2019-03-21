//
//  NewsDetailsCustomCell.swift
//  NewsAPI
//
//  Created by Tushar  Jadhav on 2019-03-20.
//  Copyright © 2019 Shital  Jadhav. All rights reserved.
//

import UIKit

class NewsDetailsCustomCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var newsImageView: UIImageView!
    @IBOutlet weak var postDateLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!

    var model: Article? {
        didSet {
            guard let model = model else {
                return
            }
            
            titleLabel.text = model.title
            sourceLabel.text = model.source.name
            postDateLabel.text = String(format: "Posted on - %@ | %@",model.publishedAt.getNewsPostDate(),model.author)
            descLabel.text = model.description
            contentLabel.text = model.content
            newsImage = AsyncImage(url: model.urlToImage)
        }
    }

    var newsImage: AsyncImage? {
        didSet {
            guard let newsImage = newsImage else {
                return
            }
            
            newsImage.startDownload()
            newsImage.completeDownload = { [weak self] image in
                self?.newsImageView.image = image
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
