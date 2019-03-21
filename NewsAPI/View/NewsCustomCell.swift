//
//  NewsCustomCell.swift
//  NewsAPI
//
//  Created by Tushar  Jadhav on 2019-03-20.
//  Copyright © 2019 Shital  Jadhav. All rights reserved.
//

import UIKit

class NewsCustomCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var newsIconImageView: UIImageView!
    @IBOutlet weak var postDateLabel: UILabel!
    
    var model: Article? {
        didSet {
            guard let model = model else {
                return
            }
        
            titleLabel.text = model.title
            sourceLabel.text = model.source.name
            postDateLabel.text = model.publishedAt.getNewsPostDate()
            newsImage = AsyncImage(url: model.urlToImage)

           // newsIconImageView.setImage(url: (URL(string: model.urlToImage))!, placeholder: UIImage(named: "user_placeholder_icon"))
        }
    }
   
    var newsImage: AsyncImage? {
        didSet {
            guard let newsImage = newsImage else {
                return
            }
            
            newsImage.startDownload()
            newsImage.completeDownload = { [weak self] image in
                self?.newsIconImageView.image = image
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        newsIconImageView.clipsToBounds = true
        newsIconImageView.layer.cornerRadius = 3.0
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        newsImage?.completeDownload = nil
    }
}
