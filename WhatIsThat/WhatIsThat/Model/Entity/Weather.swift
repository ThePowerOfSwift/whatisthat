//
//  Weather.swift
//  WhatIsThat
//
//  Created by 渡邊浩二 on 2016/11/18.
//  Copyright © 2016年 渡邊浩二. All rights reserved.
//

import RealmSwift
import ObjectMapper

class Weather: Object {
    dynamic var id = 0
    dynamic var main = ""
    dynamic var note = ""
    dynamic var icon = ""
    
    required convenience init?(map: Map) {
        self.init()
        mapping(map: map)
    }
}

extension Weather: Mappable {
    func mapping(map: Map) {
        id   <- map["id"]
        main <- map["main"]
        note <- map["description"]
        icon <- map["icon"]
    }
}
