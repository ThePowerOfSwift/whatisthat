//
//  FaceAnnotation.swift
//  WhatIsThat
//
//  Created by 渡邊浩二 on 2016/11/01.
//  Copyright © 2016年 渡邊浩二. All rights reserved.
//

import RealmSwift
import ObjectMapper

class FaceAnnotation: Object {
    dynamic var detectionConfidence    = 0.0
    dynamic var landmarkingConfidence  = 0.0
    dynamic var joyLikelihood          = ""
    dynamic var sorrowLikelihood       = ""
    dynamic var angerLikelihood        = ""
    dynamic var surpriseLikelihood     = ""
    dynamic var underExposedLikelihood = ""
    dynamic var blurredLikelihood      = ""
    dynamic var headwearLikelihood     = ""
    
    required convenience init?(map: Map) {
        self.init()
        mapping(map: map)
    }
}

// MARK: - ObjectMapper
extension FaceAnnotation: Mappable {
    func mapping(map: Map) {
        detectionConfidence    <- map["detectionConfidence"]
        landmarkingConfidence  <- map["landmarkingConfidence"]
        joyLikelihood          <- map["joyLikelihood"]
        sorrowLikelihood       <- map["sorrowLikelihood"]
        angerLikelihood        <- map["angerLikelihood"]
        surpriseLikelihood     <- map["surpriseLikelihood"]
        underExposedLikelihood <- map["underExposedLikelihood"]
        blurredLikelihood      <- map["blurredLikelihood"]
        headwearLikelihood     <- map["headwearLikelihood"]
    }
}
