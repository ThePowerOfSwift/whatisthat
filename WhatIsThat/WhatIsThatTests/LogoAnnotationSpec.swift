//
//  LogoAnnotationSpec.swift
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

class LogoAnnotationSpec: QuickSpec {
    override func spec() {
        describe("LogoAnnotation") {
            context("json mapping") {
                var jsonDictionary: [String: AnyObject]? = nil
                
                beforeEach() {
                    jsonDictionary = self.readJsonFileToDictionary(filename: "LogoAnnotation")
                }
                
                it("returns json") {
                    if let value = Mapper<LogoAnnotation>().map(JSONObject: jsonDictionary) {
                        expect(value.mid)  == "/m/045c7b"
                        expect(value.note) == "Google"
                        expect(value.score).to(equal(0.35000956))
                    }
                }
            }
        }
    }
}
