//
//  SafeSearchAnnotation.swift
//  WhatIsThat
//
//  Created by 渡邊浩二 on 2016/11/01.
//  Copyright © 2016年 渡邊浩二. All rights reserved.
//

import RealmSwift
import ObjectMapper

class SafeSearchAnnotation: Object {
    dynamic var adult    = ""
    dynamic var medical  = ""
    dynamic var spoof    = ""
    dynamic var violence = ""
    
    required convenience init?(map: Map) {
        self.init()
        mapping(map: map)
    }
}

// MARK: - ObjectMapper
extension SafeSearchAnnotation: Mappable {
    func mapping(map: Map) {
        adult    <- map["adult"]
        medical  <- map["medical"]
        spoof    <- map["spoof"]
        violence <- map["violence"]
    }
}
