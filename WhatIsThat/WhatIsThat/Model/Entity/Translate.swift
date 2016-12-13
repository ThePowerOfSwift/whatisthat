//
//  Translate.swift
//  WhatIsThat
//
//  Created by 渡邊浩二 on 2016/11/23.
//  Copyright © 2016年 渡邊浩二. All rights reserved.
//

import RealmSwift
import ObjectMapper

class Translate: Object {
    dynamic var translatedText = ""
    dynamic var detectedSourceLanguage = ""
    
    required convenience init?(map: Map) {
        self.init()
        mapping(map: map)
    }
}

extension Translate: Mappable {
    func mapping(map: Map) {
        translatedText <- map["translatedText"]
        detectedSourceLanguage <- map["detectedSourceLanguage"]
    }
}
