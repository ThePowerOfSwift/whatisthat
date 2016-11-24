//
//  Translates.swift
//  WhatIsThat
//
//  Created by 渡邊浩二 on 2016/11/23.
//  Copyright © 2016年 渡邊浩二. All rights reserved.
//

import RealmSwift
import ObjectMapper

class Translates: Object {
    dynamic var id = 0
    var translations = List<Translate>()
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    required convenience init?(map: Map) {
        self.init()
        mapping(map: map)
    }
}

// MARK: - ObjectMapper
extension Translates: Mappable {
    func mapping(map: Map) {
        translations <- (map["data.translations"], ArrayTransform<Translate>())
    }
}
