//
//  TextAnnotationEntity.swift
//  WhatIsThat
//
//  Created by 渡邊浩二 on 2016/10/30.
//  Copyright © 2016年 渡邊浩二. All rights reserved.
//

import RealmSwift
import ObjectMapper

class TextAnnotationEntity: Object {
    dynamic var adult    = ""
    dynamic var spoof    = ""
    dynamic var medical  = ""
    dynamic var violence = ""
    
    required convenience init?(map: Map) {
        self.init()
        mapping(map: map)
    }
}

// MARK: - ObjectMapper
extension TextAnnotationEntity: Mappable {
    func mapping(map: Map) {
        adult    <- map["adult"]
        spoof    <- map["spoof"]
        medical  <- map["medical"]
        violence <- map["violence"]
    }
}
