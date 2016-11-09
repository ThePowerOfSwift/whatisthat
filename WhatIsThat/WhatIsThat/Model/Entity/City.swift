

//
//  City.swift
//  WhatIsThat
//
//  Created by 渡邊浩二 on 2016/11/06.
//  Copyright © 2016年 渡邊浩二. All rights reserved.
//

import RealmSwift
import ObjectMapper

class City: Object {
    dynamic private var id = 0
    dynamic var name = ""
    var landmarks = List<Landmark>()
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    required convenience init?(map: Map) {
        self.init()
        mapping(map: map)
    }
}

extension City: Mappable {
    func mapping(map: Map) {
        name <- map["name"]
        landmarks <- (map["landmarks"], ArrayTransform<Landmark>())
    }
}
