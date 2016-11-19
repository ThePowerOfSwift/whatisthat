//
//  RealmManager.swift
//  WhatIsThat
//
//  Created by 渡邊浩二 on 2016/11/04.
//  Copyright © 2016年 渡邊浩二. All rights reserved.
//

import ObjectMapper
import RealmSwift

class RealmManager {
    static func get<T: Object>(_ type: T.Type, key: Int) -> T? {
        do {
            let realm = try Realm()
            return realm.object(ofType: T.self, forPrimaryKey: key)
        } catch let error {
            print("Failed to get RLMObject. error=\(error)")
        }
        return nil
    }
    
    static func getAll<T: Object>(_ type: T.Type) -> RealmSwift.Results<T>? {
        do {
            let realm = try Realm()
            return realm.objects(T.self)
        } catch let error {
            print("Failed to get RLMObject. error=\(error)")
        }
        return nil
    }
    
    static func save<T: Object>(_ obj: T, update: Bool = true) {
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(obj, update: update)
                print("Succeeded to save=\(obj)")
            }
        } catch let error {
            print("Failed to write RLMObject. error=\(error)")
        }
    }
    
    static func delete<T: Object>(_ value: T) {
        do {
            let realm = try Realm()
            try realm.write {
                realm.delete(value)
                print("Succeeded to delete=\(value)")
            }
        } catch let error {
            print("Failed to delete RLMObject. error=\(error)")
        }
    }
    
    static func deleteAll<T: Object>(_ type: T.Type) {
        do {
            let realm = try Realm()
            try realm.write {
                let obj = realm.objects(T.self)
                realm.delete(obj)
                print("Succeeded to delete=\(obj)")
            }
        } catch let error {
            print("Failed to delete RLMObject. error=\(error)")
        }
    }
}
