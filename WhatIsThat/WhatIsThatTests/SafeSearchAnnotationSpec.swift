//
//  SafeSearchAnnotationSpec.swift
//  WhatIsThat
//
//  Created by 渡邊浩二 on 2016/11/06.
//  Copyright © 2016年 渡邊浩二. All rights reserved.
//

import UIKit
import Quick
import Nimble
import ObjectMapper

@testable import WhatIsThat

class SafeSearchAnnotationSpec: QuickSpec {
    override func spec() {
        describe("SafeSearchAnnotation") {
            context("json mapping") {
                var jsonDictionary: [String: AnyObject]? = nil
                
                beforeEach() {
                    jsonDictionary = self.readJsonFileToDictionary(filename: "SafeSearchAnnotation")
                }
                
                it("returns json") {
                    if let value = Mapper<SafeSearchAnnotation>().map(JSONObject: jsonDictionary) {
                        expect(value.adult)    == "UNLIKELY"
                        expect(value.medical)  == "VERY_UNLIKELY"
                        expect(value.spoof)    == "VERY_UNLIKELY"
                        expect(value.violence) == "VERY_UNLIKELY"
                    }
                }
            }
        }
    }
}
