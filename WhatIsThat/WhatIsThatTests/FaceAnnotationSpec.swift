//
//  FaceAnnotationSpec.swift
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

class FaceAnnotationSpec: QuickSpec {
    override func spec() {
        describe("FaceAnnotation") {
            context("json mapping") {
                var jsonDictionary: [String: Any]? = nil
                
                beforeEach() {
                    jsonDictionary = self.readJsonFileToDictionary(filename: "FaceAnnotation")
                }
                
                it("returns json") {
                    if let value = Mapper<FaceAnnotation>().map(JSONObject: jsonDictionary) {
                        //expect(value.rollAngle).to(equal(16.066454))
                        //expect(value.panAngle).to(equal(-29.752207))
                        //expect(value.tiltAngle).to(equal(3.7352962))
                        expect(value).to(beAKindOf(FaceAnnotation.self))
                        expect(value.detectionConfidence).to(equal(0.98736823))
                        expect(value.landmarkingConfidence).to(equal(0.57041687))
                        expect(value.joyLikelihood).to(equal(0.90647823))
                        expect(value.sorrowLikelihood).to(equal(4.1928422))
                        expect(value.angerLikelihood).to(equal(0.00033951481))
                        expect(value.surpriseLikelihood).to(equal(0.0024809798))
                        expect(value.underExposedLikelihood).to(equal(3.5745124))
                        expect(value.blurredLikelihood).to(equal(0.00038755304))
                        expect(value.headwearLikelihood).to(equal(1.1718362))
                    }
                }
            }
        }
    }
}
