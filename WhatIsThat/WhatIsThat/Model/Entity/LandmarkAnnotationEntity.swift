//
//  LandmarkAnnotationEntity.swift
//  WhatIsThat
//
//  Created by 渡邊浩二 on 2016/10/30.
//  Copyright © 2016年 渡邊浩二. All rights reserved.
//

import RealmSwift
import ObjectMapper

class LandmarkAnnotationEntity: Object {
    dynamic var mid    = ""
    dynamic var detail = ""
    dynamic var score  = ""
    
    required convenience init?(map: Map) {
        self.init()
        mapping(map: map)
    }
}

// MARK: - ObjectMapper
extension LandmarkAnnotationEntity: Mappable {
    func mapping(map: Map) {
        mid    <- map["mid"]
        detail <- map["description"]
        score  <- map["score"]
    }
}
