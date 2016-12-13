//
//  WeatherMapManager.swift
//  WhatIsThat
//
//  Created by 渡邊浩二 on 2016/11/18.
//  Copyright © 2016年 渡邊浩二. All rights reserved.
//

import Alamofire
import ObjectMapper
import RealmSwift
import UIKit

class WeatherMapManager: NSObject {
    func getData(latitude: Double, longitude: Double, completion: @escaping (ApiResult) -> Void) {
        let router = ApiRouter.weatherMap(latitude, longitude)
        ApiManager.sharedInstance.request(router, mapping: WeatherMap()) { (response) in
            switch response {
            case .success(let value):
                RealmManager.save(value)
                completion(ApiResult.success)
            case.failure(let error):
                RealmManager.deleteAll(WeatherMap.self)
                completion(ApiResult.failure(error))
            }
        }
    }
    
    static func getWeatherIcon() -> UIImage? {
        guard let result = RealmManager.get(WeatherMap.self, key: 0) else { return nil }
        guard let weather = result.list.first?.weather.first?.note.lowercased() else { return nil }
        let imageFileName: String
        if weather.contains("clear") {
            imageFileName = "sunny"
        } else if weather == "light rain" {
            imageFileName = "light_rain"
        } else if weather.hasSuffix("rain") {
            imageFileName = "lower"
        } else if weather.contains("snow") {
            imageFileName = "snow"
        } else if weather.contains("lightning") {
            imageFileName = "lightning"
        } else if weather.contains("partly") {
            imageFileName = "partly_cloudy"
        } else {
            imageFileName = "cloudy"
        }
        return UIImage(named: imageFileName)
    }
}
