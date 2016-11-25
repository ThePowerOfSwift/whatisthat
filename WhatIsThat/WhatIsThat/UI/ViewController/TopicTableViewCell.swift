//
//  TopicTableViewCell.swift
//  WhatIsThat
//
//  Created by 渡邊浩二 on 2016/11/25.
//  Copyright © 2016年 渡邊浩二. All rights reserved.
//

import UIKit
import SDWebImage

class TopicTableViewCell: UITableViewCell {
    
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var thumbnailImageView: UIImageView!
    
    var category: String = "" {
        didSet {
            categoryLabel.text = category
        }
    }
    
    var title: String? = "" {
        didSet {
            titleLabel.text = title
        }
    }

    var thumbnailUrl: String = "" {
        didSet {
            guard let url = URL(string: thumbnailUrl) else { return }
            thumbnailImageView.sd_setImage(with: url)
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
