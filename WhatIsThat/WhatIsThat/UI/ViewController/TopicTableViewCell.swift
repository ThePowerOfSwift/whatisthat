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
    
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var pubDateLabel: UILabel!
    
    var title: String? = "" {
        didSet {
            titleLabel.text = title
        }
    }
    
    var pubDate: String? = "" {
        didSet {
            pubDateLabel.text = pubDate
        }
    }

    var link: String = "" {
        didSet {
            guard let url = URL(string: link) else { return }
            //thumbnailImageView.sd_setImage(with: url)
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

    override func prepareForReuse() {
        super.prepareForReuse()
        indicatorView.isHidden = false
        indicatorView.startAnimating()
    }
}
