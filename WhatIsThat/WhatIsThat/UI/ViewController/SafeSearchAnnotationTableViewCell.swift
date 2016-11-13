//
//  SafeSearchAnnotationTableViewCell.swift
//  WhatIsThat
//
//  Created by 渡邊浩二 on 2016/11/13.
//  Copyright © 2016年 渡邊浩二. All rights reserved.
//

import UIKit

class SafeSearchAnnotationTableViewCell: UITableViewCell {
    @IBOutlet weak var adultLabel: UILabel!
    @IBOutlet weak var medicalLabel: UILabel!
    @IBOutlet weak var spoofLabel: UILabel!
    @IBOutlet weak var violenceLabel: UILabel!
    
    var adult    = ""
    var medical  = ""
    var spoof    = ""
    var violence = ""
    
    func setContent() {
        adultLabel.text    = adult
        medicalLabel.text  = medical
        spoofLabel.text    = spoof
        violenceLabel.text = violence
    }
}
