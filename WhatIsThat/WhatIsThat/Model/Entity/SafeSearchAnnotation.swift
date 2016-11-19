//
//  SafeSearchAnnotation.swift
//  WhatIsThat
//
//  Created by 渡邊浩二 on 2016/11/01.
//  Copyright © 2016年 渡邊浩二. All rights reserved.
//

import RealmSwift
import ObjectMapper

enum SafeSearchLikelyHood: String {
    case UNKNOWN       = "UNKNOWN"
    case VERY_UNLIKELY = "VERY_UNLIKELY"
    case UNLIKELY      = "UNLIKELY"
    case POSSIBLE      = "POSSIBLE"
    case LIKELY        = "LIKELY"
    case VERY_LIKELY   = "VERY_LIKELY"
    
    func toScore() -> Int {
        switch self {
        case .UNKNOWN:
            return 2
        case .VERY_UNLIKELY:
            return 5
        case .UNLIKELY:
            return 4
        case .POSSIBLE:
            return 3
        case .LIKELY:
            return 1
        default:
            return 0
        }
    }
}

class SafeSearchAnnotation: Object {
    dynamic var adult    = ""
    dynamic var medical  = ""
    dynamic var spoof    = ""
    dynamic var violence = ""
    
    required convenience init?(map: Map) {
        self.init()
        mapping(map: map)
    }
}

// MARK: - ObjectMapper
extension SafeSearchAnnotation: Mappable {
    func mapping(map: Map) {
        adult    <- map["adult"]
        medical  <- map["medical"]
        spoof    <- map["spoof"]
        violence <- map["violence"]
    }
}
