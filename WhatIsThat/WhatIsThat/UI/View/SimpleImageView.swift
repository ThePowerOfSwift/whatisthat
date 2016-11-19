//
//  SimpleImageView.swift
//  WhatIsThat
//
//  Created by 渡邊浩二 on 2016/11/13.
//  Copyright © 2016年 渡邊浩二. All rights reserved.
//

import UIKit

protocol SimpleImageViewDelegate {
    func tappedCancelButton()
}

class SimpleImageView: UIView {
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var safeRateLabel: UILabel!
    
    var delegate: SimpleImageViewDelegate?
    var mainImage: UIImage? {
        didSet {
            mainImageView.image = mainImage
        }
    }
    var safeRate: Int = 0 {
        didSet {
            safeRateLabel.text = "\(safeRate)%"
        }
    }
    var adultRate: Int = 0 {
        didSet {
            if adultRate < SafeSearchLikelyHood.UNKNOWN.toScore() {
                mainImageView.addBlurEffect()
            }
        }
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    @IBAction func tappedCancelButton(_ sender: UIButton) {
        delegate?.tappedCancelButton()
    }
}
