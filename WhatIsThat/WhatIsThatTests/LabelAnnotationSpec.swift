//
//  LabelAnnotationSpec.swift
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

class LabelAnnotationSpec: QuickSpec {
    override func spec() {
        describe("LabelAnnotation") {
            context("json mapping") {
                var jsonDictionary: [String: Any]? = nil
                
                beforeEach() {
                    jsonDictionary = self.readJsonFileToDictionary(filename: "LabelAnnotation")
                }
                
                it("returns json") {
                    if let value = Mapper<LabelAnnotation>().map(JSONObject: jsonDictionary) {
                        expect(value).to(beAKindOf(LabelAnnotation.self))
                        expect(value.mid)  == "/m/021sdg"
                        expect(value.note) == "graphics"
                        expect(value.score).to(equal(0.67143095))
                    }
                }
            }
        }
    }
}
