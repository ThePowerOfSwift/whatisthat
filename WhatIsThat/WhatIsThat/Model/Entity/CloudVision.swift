//
//  CloudVision.swift
//  WhatIsThat
//
//  Created by 渡邊浩二 on 2016/10/30.
//  Copyright © 2016年 渡邊浩二. All rights reserved.
//

import RealmSwift
import ObjectMapper

class CloudVision: Object {
    dynamic var safeSearchAnnotation: SafeSearchAnnotation? = nil
    var faceAnnotations      = List<FaceAnnotation>()
    var labelAnnotations     = List<LabelAnnotation>()
    var landmarkAnnotations  = List<LandmarkAnnotation>()
    var logoAnnotations      = List<LogoAnnotation>()
    var textAnnotations      = List<TextAnnotation>()
    
    required convenience init?(map: Map) {
        self.init()
        mapping(map: map)
    }
}

// MARK: - ObjectMapper
extension CloudVision: Mappable {
    func mapping(map: Map) {
        safeSearchAnnotation <- map["safeSearchAnnotation"]
        faceAnnotations     <- (map["faceAnnotations"],     ArrayTransform<FaceAnnotation>())
        labelAnnotations    <- (map["labelAnnotations"],    ArrayTransform<LabelAnnotation>())
        landmarkAnnotations <- (map["landmarkAnnotations"], ArrayTransform<LandmarkAnnotation>())
        logoAnnotations     <- (map["logoAnnotations"],     ArrayTransform<LogoAnnotation>())
        textAnnotations     <- (map["textAnnotations"],     ArrayTransform<TextAnnotation>())
    }
}
