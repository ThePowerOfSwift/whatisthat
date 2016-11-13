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
    
    func croppingImage(toRect rect: CGRect) -> UIImage? {
        guard let imageRef = self.cgImage else { return nil }
        guard let croppedImageRef = imageRef.cropping(to: rect) else { return nil }
        return UIImage(cgImage:croppedImageRef, scale: 1.0, orientation: UIImageOrientation.right)
    }
    
    func base64EncodeImage() -> String? {
        guard var imagedata = UIImagePNGRepresentation(self) else { return nil }
        // Resize the image if it exceeds the 2MB API limit
        if imagedata.count > 2097152 {
            let oldSize: CGSize = self.size
            let newSize: CGSize = CGSize(width: 800, height: oldSize.height / oldSize.width * 800)
            imagedata = self.resizeImage(imageSize: newSize)!
        }
        return imagedata.base64EncodedString(options: .endLineWithCarriageReturn)
    }
    
    func resizeImage(imageSize: CGSize) -> Data? {
        UIGraphicsBeginImageContext(imageSize)
        self.draw(in: CGRect(x: 0, y: 0, width: imageSize.width, height: imageSize.height))
        guard let newImage = UIGraphicsGetImageFromCurrentImageContext() else { return nil }
        guard let resizedImage = UIImagePNGRepresentation(newImage) else { return nil }
        UIGraphicsEndImageContext()
        return resizedImage
    }
}
