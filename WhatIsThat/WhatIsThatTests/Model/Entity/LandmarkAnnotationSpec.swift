//
//  LandmarkAnnotationSpec.swift
//  WhatIsThat
//
//  Created by 渡邊浩二 on 2016/11/05.
//  Copyright © 2016年 渡邊浩二. All rights reserved.
//

import UIKit
import Quick
import Nimble
import ObjectMapper

@testable import WhatIsThat

class LandmarkAnnotationSpec: QuickSpec {
    override func spec() {
        describe("LandmarkAnnotation") {
            context("json mapping") {
                var jsonDictionary: [String: AnyObject]? = nil
                
                beforeEach() {
                    jsonDictionary = self.readJsonFileToDictionary(filename: "LandmarkAnnotation")
                }
                
                it("returns json") {
                    if let value = Mapper<LandmarkAnnotation>().map(JSONObject: jsonDictionary) {
                        expect(value.mid)           == "/m/021sdg"
                        expect(value.note)          == "graphics"
                        expect(String(value.score)) == "0.67143095"
                    }
                }
            }
        }
    }
}
