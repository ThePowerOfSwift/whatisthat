//
//  CloudVision.swift
//  WhatIsThat
//
//  Created by 渡邊浩二 on 2016/10/30.
//  Copyright © 2016年 渡邊浩二. All rights reserved.
//

import RealmSwift
import ObjectMapper

class CloudVisionEntity : Object {
//    dynamic var safeSearchAnnotation: SafeSearchAnnotationEntity?
    var faceAnnotations      = List<FaceAnnotationEntity>()
    var labelAnnotations     = List<LabelAnnotationEntity>()
    var landmarkAnnotations  = List<LandmarkAnnotationEntity>()
    var logoAnnotations      = List<LogoAnnotationEntity>()
    var textAnnotations      = List<TextAnnotationEntity>()
    
    required convenience init?(map: Map) {
        self.init()
        mapping(map: map)
    }
}

// MARK: - ObjectMapper
extension CloudVisionEntity : Mappable {
    func mapping(map: Map) {
//        safeSearchAnnotation <- map["responses.safeSearchAnnotation"]
        faceAnnotations      <- map["responses.faceAnnotations"]
        labelAnnotations     <- map["responses.labelAnnotations"]
        landmarkAnnotations  <- map["responses.landmarkAnnotations"]
        logoAnnotations      <- map["responses.logoAnnotations"]
        textAnnotations      <- map["responses.textAnnotations"]
    }
}
