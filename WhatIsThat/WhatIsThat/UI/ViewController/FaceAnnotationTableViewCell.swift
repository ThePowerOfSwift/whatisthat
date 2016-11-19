//
//  FaceAnnotationTableViewCell.swift
//  WhatIsThat
//
//  Created by 渡邊浩二 on 2016/11/13.
//  Copyright © 2016年 渡邊浩二. All rights reserved.
//

import UIKit

class FaceAnnotationTableViewCell: UITableViewCell {
    @IBOutlet weak var joyLikelihoodLabel: UILabel!
    @IBOutlet weak var surpriseLikelihoodLabel: UILabel!
    @IBOutlet weak var sorrowLikelihoodLabel: UILabel!
    @IBOutlet weak var angerLikelihoodLabel: UILabel!
    
    var result: FaceAnnotation?
    
    func setContent() {
        guard let result = result else { return }
        joyLikelihoodLabel.text      = String(result.joyLikelihood)
        surpriseLikelihoodLabel.text = String(result.surpriseLikelihood)
        sorrowLikelihoodLabel.text   = String(result.sorrowLikelihood)
        angerLikelihoodLabel.text    = String(result.angerLikelihood)
    }
}
