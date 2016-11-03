//
//  CloudVisionManager.swift
//  WhatIsThat
//
//  Created by 渡邊浩二 on 2016/11/02.
//  Copyright © 2016年 渡邊浩二. All rights reserved.
//

import Alamofire
import ObjectMapper
import RealmSwift
import UIKit

class CloudVisionManager: NSObject {
    func getData(image: UIImage, completion: @escaping (ApiResult) -> Void) {
        let imageString = image.base64EncodeImage()
        let params: [String: Any] = [
            "requests": [
                "image": [
                    "content": imageString!
                ],
                "features": [
//                    [
//                        "type": "SAFE_SEARCH_DETECTION",
//                        "maxResults": 1
//                    ],
                    [
                        "type": "FACE_DETECTION",
                        "maxResults": 1
                    ],
                    [
                        "type": "LABEL_DETECTION",
                        "maxResults": 5
                    ],
                    [
                        "type": "LANDMARK_DETECTION",
                        "maxResults": 5
                    ],
                    [
                        "type": "LOGO_DETECTION",
                        "maxResults": 3
                    ],
                    [
                        "type": "TEXT_DETECTION",
                        "maxResults": 5
                    ]
                ]
            ]
        ]
        let router = ApiRouter.cloudVision(params)
        ApiManager.sharedInstance.request(router, mapping: CloudVisionEntity()) { (response) in
            print("response=\(response)")
            switch response {
            case .success(let value):
                let realm = try! Realm()
                try! realm.write {
                    realm.add(value)
                }
                completion(ApiResult.success)
            case.failure(let error):
                let realm = try! Realm()
                try! realm.write {
                    realm.delete(realm.objects(CloudVisionEntity.self))
                }
                completion(ApiResult.failure(error))
            }
        }
    }
}
