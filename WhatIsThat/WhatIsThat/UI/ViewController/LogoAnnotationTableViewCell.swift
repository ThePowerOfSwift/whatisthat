//
//  LogoAnnotationTableViewCell.swift
//  WhatIsThat
//
//  Created by 渡邊浩二 on 2016/11/13.
//  Copyright © 2016年 渡邊浩二. All rights reserved.
//

import UIKit

protocol LogoAnnotationTableViewCellDelegate {
    func gotoSearchPage(keyword: String, isImageSearch: Bool)
}

class LogoAnnotationTableViewCell: UITableViewCell {
    @IBOutlet weak var localeLabel: UILabel!
    @IBOutlet weak var noteLabel: UILabel!
    
    var delegate: LogoAnnotationTableViewCellDelegate?
    var note   = ""
    var locale = ""
    var isTranslated = false
    
    func setContent() {
        noteLabel.text = (isTranslated ? "   - " : "") + note
        localeLabel.text = locale == "" ? "??" : locale.uppercased()
    }
    
    @IBAction func tappedSearchKeywordButton(_ sender: UIButton) {
        delegate?.gotoSearchPage(keyword: note, isImageSearch: false)
    }
    
    @IBAction func tappedSearchImageButton(_ sender: UIButton) {
        delegate?.gotoSearchPage(keyword: note, isImageSearch: true)
    }
    
    @IBAction func tappedCopyButton(_ sender: UIButton) {
        UIPasteboard.general.string = note
    }
}
