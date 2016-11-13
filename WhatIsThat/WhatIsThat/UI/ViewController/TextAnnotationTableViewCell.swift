//
//  TextAnnotationTableViewCell.swift
//  WhatIsThat
//
//  Created by 渡邊浩二 on 2016/11/13.
//  Copyright © 2016年 渡邊浩二. All rights reserved.
//

import UIKit

protocol TextAnnotationTableViewCellDelegate {
    func gotoSearchPage(keyword: String, isImageSearch: Bool)
}

class TextAnnotationTableViewCell: UITableViewCell {
    @IBOutlet weak var localeLabel: UILabel!
    @IBOutlet weak var noteLabel: UILabel!
    
    var delegate: TextAnnotationTableViewCellDelegate?
    var note   = ""
    var locale = ""
    
    func setContent() {
        noteLabel.text = note
        localeLabel.text = locale == "" ? "??" : locale
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
