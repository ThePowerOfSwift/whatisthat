//
//  ApiManager.swift
//  WhatIsThat
//
//  Created by 渡邊浩二 on 2016/10/30.
//  Copyright © 2016年 渡邊浩二. All rights reserved.
//

import Alamofire
import ObjectMapper

enum ApiResult {
    case success
    case failure(Error)
}

class ApiManager: NSObject {
    var manager: Alamofire.SessionManager
    
    static let sharedInstance: ApiManager = {
        let configuration = URLSessionConfiguration.default
        let manager = SessionManager(configuration: configuration, serverTrustPolicyManager: nil)
        return ApiManager(manager: manager)
    }()
    
    init(manager: SessionManager) {
        self.manager = manager
    }
    
    func request<T: Mappable>(_ router: ApiRouter, mapping: T, completion: @escaping (Alamofire.Result<T>) -> Void) {
        Alamofire.request(router).responseJSON { (response) -> Void in
            switch response.result {
            case .failure(let error):
                return completion(Result.failure(error))
            case .success(let rawValue):
                print("[API Response] rawValue=\(rawValue)")
                guard let dictionary = rawValue as? [String: AnyObject] else {
                    let error = NSError(domain: "[API response error] response is not dictionary format.", code: -1, userInfo: nil)
                    return completion(Result.failure(error))
                }
                guard dictionary["error"] == nil else {
                    let error = NSError(domain: "[API response error] errors occured.", code: -1, userInfo: dictionary["error"] as? [String : Any])
                    return completion(Result.failure(error))
                }
                guard let value = Mapper<T>().map(JSONObject: dictionary) else {
                    let error = NSError(domain: "[API response error] failed to parse.", code: -1, userInfo: dictionary)
                    return completion(Result.failure(error))
                }
                return completion(Result.success(value))
            }
        }
    }
}
