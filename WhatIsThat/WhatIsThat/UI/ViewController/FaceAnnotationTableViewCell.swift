//
//  FaceAnnotationTableViewCell.swift
//  WhatIsThat
//
//  Created by 渡邊浩二 on 2016/11/13.
//  Copyright © 2016年 渡邊浩二. All rights reserved.
//

import UIKit

class FaceAnnotationTableViewCell: UITableViewCell {
    @IBOutlet weak var detectionConfidenceLabel: UILabel!
    @IBOutlet weak var landmarkingConfidenceLabel: UILabel!
    @IBOutlet weak var joyLikelihoodLabel: UILabel!
    @IBOutlet weak var sorrowLikelihoodLabel: UILabel!
    @IBOutlet weak var angerLikelihoodLabel: UILabel!
    @IBOutlet weak var surpriseLikelihoodLabel: UILabel!
    @IBOutlet weak var underExposedLikelihoodLabel: UILabel!
    @IBOutlet weak var blurredLikelihoodLabel: UILabel!
    @IBOutlet weak var headwearLikelihoodLabel: UILabel!
    
    var detectionConfidence    = ""
    var landmarkingConfidence  = ""
    var joyLikelihood          = ""
    var sorrowLikelihood       = ""
    var angerLikelihood        = ""
    var surpriseLikelihood     = ""
    var underExposedLikelihood = ""
    var blurredLikelihood      = ""
    var headwearLikelihood     = ""
    
    func setContent() {
        detectionConfidenceLabel.text    = detectionConfidence
        landmarkingConfidenceLabel.text  = landmarkingConfidence
        joyLikelihoodLabel.text          = joyLikelihood
        sorrowLikelihoodLabel.text       = sorrowLikelihood
        angerLikelihoodLabel.text        = angerLikelihood
        surpriseLikelihoodLabel.text     = surpriseLikelihood
        underExposedLikelihoodLabel.text = underExposedLikelihood
        blurredLikelihoodLabel.text      = blurredLikelihood
        headwearLikelihoodLabel.text     = headwearLikelihood
    }
}
