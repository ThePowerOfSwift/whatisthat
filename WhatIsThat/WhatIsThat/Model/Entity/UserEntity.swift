//
//  UserEntity.swift
//  WhatIsThat
//
//  Created by 渡邊浩二 on 2016/10/30.
//  Copyright © 2016年 渡邊浩二. All rights reserved.
//

import Realm
import ObjectMapper

class UserEntity : RLMObject {
    
    dynamic var id = ""
    dynamic var name = ""
    
    // initializer で mapping(map: Map) を呼び出す
    required convenience init?(map: Map) {
        self.init()
        mapping(map: map)
    }
    
}

// MARK: - ObjectMapper
extension UserEntity : Mappable {
    
    func mapping(map: Map) {
        id   <- map["Result.user.id"]
        name <- map["Result.user.name"]
    }
    
}
