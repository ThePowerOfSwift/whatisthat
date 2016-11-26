//
//  TopicTableViewCell.swift
//  WhatIsThat
//
//  Created by 渡邊浩二 on 2016/11/25.
//  Copyright © 2016年 渡邊浩二. All rights reserved.
//

import Haneke
import UIKit

class TopicTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var pubDateLabel: UILabel!
    
    var title: String?
    var pubDate: String?
    var link: String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        thumbnailImageView.image = nil
        titleLabel.text = ""
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        titleLabel.text = title
        pubDateLabel.text = pubDate

//        guard let link = link, link.characters.count > 0 else { return }
//        
//        let cache = Shared.imageCache
//        cache.fetch(key: link).onSuccess { image in
//            self.thumbnailImageView.image = image
//        }
    }
}
