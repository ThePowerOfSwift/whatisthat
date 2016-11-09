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
    enum Likelihood: String {
        case Unknown      = "UNKNOWN"
        case VeryUnlikely = "VERY_UNLIKELY"
        case Unlikely     = "UNLIKELY"
        case Possible     = "POSSIBLE"
        case Likely       = "LIKELY"
        case VeryLikely   = "VERY_LIKELY"
        
        func isValidContent() -> Bool {
            switch self {
            case .Unknown, .VeryUnlikely, .Unlikely:
                return true
            default:
                return false
            }
        }
    }
    
    func getData(image: UIImage, completion: @escaping (ApiResult) -> Void) {
        let imageString = image.base64EncodeImage()
        let params: [String: Any] = [
            "requests": [
                "image": [
                    "content": imageString!
                ],
                "features": [
                    [
                        "type": "SAFE_SEARCH_DETECTION",
                        "maxResults": 1
                    ],
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
        ApiManager.sharedInstance.request(router, mapping: CloudVisions()) { (response) in
            switch response {
            case .success(let value):
                RealmManager.save(value)
                completion(ApiResult.success)
            case.failure(let error):
                RealmManager.deleteAll(CloudVisions.self)
                completion(ApiResult.failure(error))
            }
        }
    }
}
