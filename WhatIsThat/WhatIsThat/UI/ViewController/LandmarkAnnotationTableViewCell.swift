//
//  LandmarkAnnotationTableViewCell.swift
//  WhatIsThat
//
//  Created by 渡邊浩二 on 2016/11/13.
//  Copyright © 2016年 渡邊浩二. All rights reserved.
//

import UIKit

protocol LandmarkAnnotationTableViewCellDelegate {
    func gotoSearchPage(keyword: String, isImageSearch: Bool)
}

class LandmarkAnnotationTableViewCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    
    var delegate: LandmarkAnnotationTableViewCellDelegate?
    var name = "" {
        didSet {
            setContent()
        }
    }
    
    func setContent() {
        nameLabel.text = name
    }
    
    @IBAction func tappedSearchKeywordButton(_ sender: UIButton) {
        delegate?.gotoSearchPage(keyword: name, isImageSearch: false)
    }
    
    @IBAction func tappedSearchImageButton(_ sender: UIButton) {
        delegate?.gotoSearchPage(keyword: name, isImageSearch: true)
    }
    
    @IBAction func tappedCopyButton(_ sender: UIButton) {
        UIPasteboard.general.string = nameLabel.text
    }
}
