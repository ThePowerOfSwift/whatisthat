//
//  UIImage.swift
//  WhatIsThat
//
//  Created by 渡邊浩二 on 2016/10/22.
//  Copyright © 2016年 渡邊浩二. All rights reserved.
//

import UIKit
import AVFoundation

extension UIImage {
    class func imageFromSampleBuffer(sampleBuffer :CMSampleBuffer) -> UIImage? {
        guard let imageBuffer: CVImageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return nil }
        CVPixelBufferLockBaseAddress(imageBuffer, CVPixelBufferLockFlags(rawValue: CVOptionFlags(0)))
        let baseAddress: UnsafeMutableRawPointer = CVPixelBufferGetBaseAddressOfPlane(imageBuffer, 0)!
        let bytesPerRow: UInt = UInt(CVPixelBufferGetBytesPerRow(imageBuffer))
        let width  = Int(CVPixelBufferGetWidth(imageBuffer))
        let height = Int(CVPixelBufferGetHeight(imageBuffer))
        let colorSpace: CGColorSpace = CGColorSpaceCreateDeviceRGB()
        let bitsPerCompornent: UInt = 8
        let bitmapInfo = CGBitmapInfo(rawValue: (CGBitmapInfo.byteOrder32Little.rawValue | CGImageAlphaInfo.premultipliedFirst.rawValue) as UInt32)
        let newContext = CGContext(data: baseAddress, width: width, height: height, bitsPerComponent: Int(bitsPerCompornent), bytesPerRow: Int(bytesPerRow), space: colorSpace, bitmapInfo: bitmapInfo.rawValue)!
        let imageRef: CGImage = newContext.makeImage()!
        return UIImage(cgImage: imageRef, scale: 1.0, orientation: UIImageOrientation.right)
    }
    
    func croppIngimage(toRect rect: CGRect) -> UIImage? {
        guard let imageRef = self.cgImage else { return nil }
        guard let croppedImageRef = imageRef.cropping(to: rect) else { return nil }
        return UIImage(cgImage:croppedImageRef, scale: 1.0, orientation: UIImageOrientation.right)
    }
}
