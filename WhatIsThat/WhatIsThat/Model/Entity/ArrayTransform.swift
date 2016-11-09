//
//  ArrayTransform.swift
//  WhatIsThat
//
//  Created by 渡邊浩二 on 2016/11/04.
//  Copyright © 2016年 渡邊浩二. All rights reserved.
//

import UIKit
import RealmSwift
import ObjectMapper

class ArrayTransform<T:RealmSwift.Object> : TransformType where T:Mappable {
    typealias Object = List<T>
    typealias JSON = Array<Any>
    
    public func transformFromJSON(_ value: Any?) -> List<T>? {
        let result = List<T>()
        if let value = value as? Array<Any> {
            value.forEach({ (entry) in
                let mapper = Mapper<T>()
                if let model = mapper.map(JSONObject: entry) {
                    result.append(model)
                }
            })
        }
        return result
    }
    
    func transformToJSON(_ value: List<T>?) -> Array<Any>? {
        if let value = value, value.count > 0 {
            var result = Array<T>()
            value.forEach({ (entry) in
                result.append(entry)
            })
            return result
        }
        return nil
    }
}
