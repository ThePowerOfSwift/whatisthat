//
//  Landmark.swift
//  WhatIsThat
//
//  Created by 渡邊浩二 on 2016/11/06.
//  Copyright © 2016年 渡邊浩二. All rights reserved.
//

import RealmSwift
import ObjectMapper

class Landmark: Object {
    dynamic var name = ""
    
    required convenience init?(map: Map) {
        self.init()
        mapping(map: map)
    }
}

extension Landmark: Mappable {
    func mapping(map: Map) {
        name <- map["name"]
    }
}
