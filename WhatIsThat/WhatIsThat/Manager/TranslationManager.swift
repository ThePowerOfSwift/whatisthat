//
//  TranslationManager.swift
//  WhatIsThat
//
//  Created by 渡邊浩二 on 2016/11/23.
//  Copyright © 2016年 渡邊浩二. All rights reserved.
//

import Alamofire
import ObjectMapper
import RealmSwift
import UIKit

class TranslationManager: NSObject {
    func getData(typeId: CloudVisionTypeId, queries: [String], source: String, target: String, completion: @escaping (ApiResult) -> Void) {
        let router = ApiRouter.translate(queries, source, target)
        ApiManager.sharedInstance.request(router, mapping: Translates()) { (response) in
            switch response {
            case .success(let value):
                value.id = typeId.rawValue
                RealmManager.save(value)
                completion(ApiResult.success)
            case.failure(let error):
                RealmManager.deleteAll(Translates.self)
                completion(ApiResult.failure(error))
            }
        }
    }
}
