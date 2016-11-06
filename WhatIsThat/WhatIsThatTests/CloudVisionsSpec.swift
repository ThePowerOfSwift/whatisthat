//
//  CloudVisionsSpec.swift
//  WhatIsThat
//
//  Created by 渡邊浩二 on 2016/11/06.
//  Copyright © 2016年 渡邊浩二. All rights reserved.
//

import UIKit
import Quick
import Nimble
import ObjectMapper
import RealmSwift

@testable import WhatIsThat

class CloudVisionsSpec: QuickSpec {
    override func spec() {
        describe("CloudVisions") {
            context("json mapping") {
                var jsonDictionary: [String: Any]? = nil
                
                beforeEach() {
                    jsonDictionary = self.readJsonFileToDictionary(filename: "CloudVisions")
                }
                
                it("returns json") {
                    if let value = Mapper<CloudVisions>().map(JSONObject: jsonDictionary!) {
                        expect(value).to(beAKindOf(CloudVisions.self))
                    }
                }
            }
        }
    }
}
