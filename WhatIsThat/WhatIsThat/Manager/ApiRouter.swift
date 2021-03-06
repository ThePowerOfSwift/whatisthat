//
//  Router.swift
//  WhatIsThat
//
//  Created by 渡邊浩二 on 2016/10/30.
//  Copyright © 2016年 渡邊浩二. All rights reserved.
//

import Alamofire
import ObjectMapper

protocol router {
    var path: String { get }
    var method: Alamofire.HTTPMethod { get }
}

enum ApiRouter: URLRequestConvertible, router {
    
    case cloudVision([String: Any])
    case weatherMap(Double, Double)
    case translate([String], String, String)
    
    var path: String {
        switch self {
        case .cloudVision(_):
            return "https://vision.googleapis.com/v1/images:annotate?key=\(Const.API.GoogleApiKey.ApiKey)"
        case .weatherMap(let latitude, let longitude):
            return "http://api.openweathermap.org/data/2.5/forecast?APPID=\(Const.API.WeatherMap.ApiKey)&lat=\(latitude)&lon=\(longitude)"
        case .translate(let queries, let source, let target):
            var query = ""
            queries.forEach({ (key) in
                if let encodedKey = key.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
                    query += "&q=\(encodedKey)"
                }
            })
            if source.characters.count > 0 {
                query += "&source=\(source)"
            }
            return "https://translation.googleapis.com/language/translate/v2?key=\(Const.API.GoogleApiKey.ApiKey)&target=\(target)\(query)"
        }
    }

    var method: Alamofire.HTTPMethod {
        switch self {
        case .cloudVision(_):
            return .post
        case .weatherMap(_):
            return .get
        case .translate(_):
            return .get
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        var request = URLRequest(url: URL(string: path)!)
        request.httpMethod = method.rawValue
        //request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(Bundle.main.bundleIdentifier ?? "", forHTTPHeaderField: "X-Ios-Bundle-Identifier")
        
        switch self {
        case .cloudVision(let params):
            return try! Alamofire.JSONEncoding.default.encode(request, with: params)
        case .weatherMap(_):
            return try! Alamofire.JSONEncoding.default.encode(request, with: nil)
        case .translate(_):
            return try! Alamofire.JSONEncoding.default.encode(request, with: nil)
        }
    }
}
