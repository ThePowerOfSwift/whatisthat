//
//  LabelAnnotation.swift
//  WhatIsThat
//
//  Created by 渡邊浩二 on 2016/10/30.
//  Copyright © 2016年 渡邊浩二. All rights reserved.
//

import RealmSwift
import ObjectMapper

class LabelAnnotation: Object {
    dynamic var mid   = ""
    dynamic var note  = ""
    dynamic var score = 0.0
    
    required convenience init?(map: Map) {
        self.init()
        mapping(map: map)
    }
}

// MARK: - ObjectMapper
extension LabelAnnotation: Mappable {
    func mapping(map: Map) {
        mid   <- map["mid"]
        note  <- map["description"]
        score <- map["score"]
    }
}
