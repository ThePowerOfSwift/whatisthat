//
//  TextAnnotation.swift
//  WhatIsThat
//
//  Created by 渡邊浩二 on 2016/10/30.
//  Copyright © 2016年 渡邊浩二. All rights reserved.
//

import RealmSwift
import ObjectMapper

class TextAnnotation: Object {
    dynamic var locale = ""
    dynamic var note   = ""
    
    required convenience init?(map: Map) {
        self.init()
        mapping(map: map)
    }
}

// MARK: - ObjectMapper
extension TextAnnotation: Mappable {
    func mapping(map: Map) {
        locale <- map["locale"]
        note   <- map["description"]
    }
}
