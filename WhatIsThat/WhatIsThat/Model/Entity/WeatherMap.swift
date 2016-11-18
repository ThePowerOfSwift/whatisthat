//
//  WeatherMap.swift
//  WhatIsThat
//
//  Created by 渡邊浩二 on 2016/11/18.
//  Copyright © 2016年 渡邊浩二. All rights reserved.
//

import RealmSwift
import ObjectMapper


class WeatherMap: Object {
    dynamic private var id = 0
    dynamic var name      = ""
    dynamic var country   = ""
    dynamic var coordLon  = ""
    dynamic var coordLat  = ""
    var list = List<WeatherList>()
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    required convenience init?(map: Map) {
        self.init()
        mapping(map: map)
    }
}

// MARK: - ObjectMapper
extension WeatherMap: Mappable {
    func mapping(map: Map) {
        name     <- map["city.name"]
        country  <- map["city.country"]
        coordLon <- map["city.coord.lon"]
        coordLat <- map["city.coord.lat"]
        list     <- (map["list"], ArrayTransform<WeatherList>())
    }
}
