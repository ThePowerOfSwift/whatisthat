//
//  ResultTableViewCell.swift
//  WhatIsThat
//
//  Created by 渡邊浩二 on 2016/11/06.
//  Copyright © 2016年 渡邊浩二. All rights reserved.
//

import UIKit

protocol LabelAnnotationTableViewCellDelegate {
    func gotoSearchPage(keyword: String, isImageSearch: Bool)
}

class LabelAnnotationTableViewCell: UITableViewCell {
    @IBOutlet weak var noteLabel: UILabel!

    var delegate: LabelAnnotationTableViewCellDelegate?
    var note = "" {
        didSet {
            setContent()
        }
    }
    
    func setContent() {
        noteLabel.text = note
    }
    
    @IBAction func tappedSearchKeywordButton(_ sender: UIButton) {
        delegate?.gotoSearchPage(keyword: note, isImageSearch: false)
    }
    
    @IBAction func tappedSearchImageButton(_ sender: UIButton) {
        delegate?.gotoSearchPage(keyword: note, isImageSearch: true)
    }
    
    @IBAction func tappedCopyButton(_ sender: UIButton) {
        UIPasteboard.general.string = noteLabel.text
    }
}
