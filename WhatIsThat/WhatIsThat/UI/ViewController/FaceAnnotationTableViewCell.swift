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
    
    var result: FaceAnnotation? {
        didSet {
            setContent()
        }
    }
    
    func setContent() {
        guard let result = result else { return }
        joyLikelihoodLabel.text      = getExpressionScore(likelihood: result.joyLikelihood) + "%"
        surpriseLikelihoodLabel.text = getExpressionScore(likelihood: result.surpriseLikelihood) + "%"
        sorrowLikelihoodLabel.text   = getExpressionScore(likelihood: result.sorrowLikelihood) + "%"
        angerLikelihoodLabel.text    = getExpressionScore(likelihood: result.angerLikelihood) + "%"
    }
    
    private func getExpressionScore(likelihood: String) -> String {
        if Likelihood.VeryLikely.rawValue == likelihood {
            return "100"
        } else if Likelihood.Likely.rawValue == likelihood {
            return "80"
        } else if Likelihood.Possible.rawValue == likelihood {
            return "60"
        } else if Likelihood.Unlikely.rawValue == likelihood {
            return "20"
        } else if Likelihood.VeryUnlikely.rawValue == likelihood {
            return "0"
        }
        return "40"
    }
}
