
//
//  QuickSpec+Extension.swift
//  WhatIsThat
//
//  Created by 渡邊浩二 on 2016/11/05.
//  Copyright © 2016年 渡邊浩二. All rights reserved.
//

import UIKit
import Quick
import Nimble

extension QuickSpec {
    func readJsonFileToDictionary(filename: String) -> [String: AnyObject]? {
        if let path = Bundle(for: type(of: self)).path(forResource: filename, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
                if let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: AnyObject] {
                    return json
                } else {
                    print("Could not get json from file, make sure that file contains valid json.")
                }
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        } else {
            print("Invalid filename/path.")
        }
        return nil
    }
    
    func readJsonFileToString(filename: String) -> String? {
        if let path = Bundle(for: type(of: self)).path(forResource: filename, ofType: "json") {
            do {
                let json = try String(contentsOfFile: path)
                return json
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        } else {
            print("Invalid filename/path.")
        }
        return nil
    }
}
