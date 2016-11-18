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
    func getData(cityname: String, completion: @escaping (ApiResult) -> Void) {
        let router = ApiRouter.weatherMap(cityname)
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
}
