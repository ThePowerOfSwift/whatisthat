//
//  TextAnnotationSpec.swift
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

class TextAnnotationSpec: QuickSpec {
    override func spec() {
        describe("TextAnnotation") {
            context("json mapping") {
                var jsonDictionary: [String: AnyObject]? = nil
                
                beforeEach() {
                    jsonDictionary = self.readJsonFileToDictionary(filename: "TextAnnotation")
                }
                
                it("returns json") {
                    if let value = Mapper<TextAnnotation>().map(JSONObject: jsonDictionary) {
                        expect(value.locale) == "en"
                        expect(value.note)   == "Google\n"
                    }
                }
            }
        }
    }
}
