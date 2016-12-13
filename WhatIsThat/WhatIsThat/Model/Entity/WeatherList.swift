//
//  WeatherList.swift
//  WhatIsThat
//
//  Created by 渡邊浩二 on 2016/11/18.
//  Copyright © 2016年 渡邊浩二. All rights reserved.
//

import RealmSwift
import ObjectMapper

class WeatherList: Object {
    dynamic var dt        = 0
    dynamic var temp      = 0
    dynamic var tempMin   = 0
    dynamic var tempMax   = 0
    dynamic var pressure  = 0
    dynamic var seaLevel  = 0
    dynamic var grndLevel = 0
    dynamic var humidity  = 0
    dynamic var tempKf    = 0
    dynamic var clouds    = ""
    dynamic var windSpeed = 0
    dynamic var windDeg   = 0
    var weather = List<Weather>()
    
    required convenience init?(map: Map) {
        self.init()
        mapping(map: map)
    }
}

extension WeatherList: Mappable {
    func mapping(map: Map) {
        dt         <- map["dt"]
        temp       <- map["main.temp"]
        tempMin    <- map["main.temp_min"]
        tempMax    <- map["main.temp_max"]
        pressure   <- map["main.pressure"]
        seaLevel   <- map["main.sea_level"]
        grndLevel  <- map["main.grnd_level"]
        humidity   <- map["main.humidity"]
        clouds     <- map["clouds.all"]
        windSpeed  <- map["wind.speed"]
        windDeg    <- map["wind.deg"]
        weather    <- (map["weather"], ArrayTransform<Weather>())
    }
}
