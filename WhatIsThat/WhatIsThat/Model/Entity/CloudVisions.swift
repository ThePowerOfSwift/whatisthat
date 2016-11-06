
//
//  CloudVisions.swift
//  WhatIsThat
//
//  Created by 渡邊浩二 on 2016/11/06.
//  Copyright © 2016年 渡邊浩二. All rights reserved.
//

import RealmSwift
import ObjectMapper

class CloudVisions: Object {
    dynamic private var id = 0
    var responses = List<CloudVision>()
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    required convenience init?(map: Map) {
        self.init()
        mapping(map: map)
    }
}

// MARK: - ObjectMapper
extension CloudVisions: Mappable {
    func mapping(map: Map) {
        responses <- (map["responses"], ArrayTransform<CloudVision>())
    }
}
