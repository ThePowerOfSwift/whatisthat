//
//  ResultTableViewCell.swift
//  WhatIsThat
//
//  Created by 渡邊浩二 on 2016/11/06.
//  Copyright © 2016年 渡邊浩二. All rights reserved.
//

import UIKit

protocol ResultTableViewCellDelegate {
    func gotoSearchPage(keyword: String, isImageSearch: Bool)
}

class ResultTableViewCell: UITableViewCell {
    var delegate: ResultTableViewCellDelegate?
    var note: String = "" {
        didSet {
            setContent()
        }
    }
    
    @IBOutlet weak var noteLabel: UILabel!
    
    func setContent() {
        noteLabel.text = note
    }
    
    @IBAction func tappedCopyButton(_ sender: UIButton) {
        UIPasteboard.general.string = noteLabel.text
    }
    
    @IBAction func tappedSearchKeywordButton(_ sender: UIButton) {
        delegate?.gotoSearchPage(keyword: note, isImageSearch: false)
    }
    
    @IBAction func tappedSearchImageButton(_ sender: UIButton) {
        delegate?.gotoSearchPage(keyword: note, isImageSearch: true)
    }
}
