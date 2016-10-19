//
//  TopViewController.swift
//  WhatIsThat
//
//  Created by 渡邊浩二 on 2016/10/13.
//  Copyright © 2016年 渡邊浩二. All rights reserved.
//

import UIKit
import GLKit
import AVFoundation

class TopViewController: UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate {
    var videoDisplayView: GLKView!
    var videoDisplayViewRect: CGRect!
    var renderContext: CIContext!
    var cpsSession: AVCaptureSession!
    var isCaptured: Bool = false
    var touchPos = CGPoint(x: 0, y: 0)
    
    override func viewWillAppear(_ animated: Bool) {
        //画面の生成
        initDisplay()
        
        // カメラの使用準備.
        initCamera()
        
        // ジェスチャーの生成
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapGesture(touch:)))
        tap.numberOfTapsRequired = 1
        view.addGestureRecognizer(tap)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        // カメラの停止とメモリ解放.
        self.cpsSession.stopRunning()
        for output in self.cpsSession.outputs {
            self.cpsSession.removeOutput(output as! AVCaptureOutput)
        }
        
        for input in self.cpsSession.inputs {
            self.cpsSession.removeInput(input as! AVCaptureInput)
        }
        self.cpsSession = nil
    }
    
    func initDisplay() {
        videoDisplayView = GLKView(frame: view.bounds, context: EAGLContext(api: .openGLES2))
        videoDisplayView.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI_2))
        videoDisplayView.frame = view.bounds
        view.addSubview(videoDisplayView)
        
        displayCorporateLogo()
        
        renderContext = CIContext(eaglContext: videoDisplayView.context)
        videoDisplayView.bindDrawable()
        videoDisplayViewRect = CGRect(x: 0, y: 0, width: videoDisplayView.drawableWidth, height: videoDisplayView.drawableHeight)
    }
    
    func initCamera() {
        // カメラからの入力を作成
        var device: AVCaptureDevice!
        
        // 背面カメラの検索
        for _device: Any in AVCaptureDevice.devices() {
            if (_device as AnyObject).position == AVCaptureDevicePosition.back {
                device = _device as! AVCaptureDevice
            }
        }
        
        // 入力データの取得
        do {
            let deviceInput: AVCaptureDeviceInput = try AVCaptureDeviceInput(device: device)
            // 出力データの取得
            let videoDataOutput: AVCaptureVideoDataOutput = AVCaptureVideoDataOutput()
            
            // カラーチャンネルの設定
            videoDataOutput.videoSettings = [kCVPixelBufferPixelFormatTypeKey as AnyHashable : Int(kCVPixelFormatType_32BGRA)]
            
            // 画像をキャプチャするキューを指定
            videoDataOutput.setSampleBufferDelegate(self, queue: DispatchQueue.main)
            
            // キューがブロックされているときに新しいフレームが来たら削除
            videoDataOutput.alwaysDiscardsLateVideoFrames = true
            
            // セッションの使用準備
            self.cpsSession = AVCaptureSession()
            
            // Input
            if (self.cpsSession.canAddInput(deviceInput)) {
                self.cpsSession.addInput(deviceInput as AVCaptureDeviceInput)
            }
            // Output
            if (self.cpsSession.canAddOutput(videoDataOutput)) {
                self.cpsSession.addOutput(videoDataOutput)
            }
            //解像度の指定
            self.cpsSession.sessionPreset = AVCaptureSessionPresetMedium
            
            self.cpsSession.startRunning()
        } catch (let error) {
            print(error)
        }
    }
    
    func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputSampleBuffer sampleBuffer: CMSampleBuffer!, from connection: AVCaptureConnection!) {
        //SampleBufferから画像を取得
        let imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer)
        let opaqueBuffer = Unmanaged<CVImageBuffer>.passUnretained(imageBuffer!).toOpaque()
        let pixelBuffer = Unmanaged<CVPixelBuffer>.fromOpaque(opaqueBuffer).takeUnretainedValue()
        let outputImage = CIImage(cvPixelBuffer: pixelBuffer, options: nil)
        
        //補正
        var drawFrame = outputImage.extent
        let imageAR = drawFrame.width / drawFrame.height
        let viewAR = videoDisplayViewRect.width / videoDisplayViewRect.height
        if imageAR > viewAR {
            drawFrame.origin.x += (drawFrame.width - drawFrame.height * viewAR) / 2.0
            drawFrame.size.width = drawFrame.height / viewAR
        } else {
            drawFrame.origin.y += (drawFrame.height - drawFrame.width / viewAR) / 2.0
            drawFrame.size.height = drawFrame.width / viewAR
        }
        
        //出力
        videoDisplayView.bindDrawable()
        if videoDisplayView.context != EAGLContext.current() {
            EAGLContext.setCurrent(videoDisplayView.context)
        }
        renderContext.draw(outputImage, in: videoDisplayViewRect, from: drawFrame)
        videoDisplayView.display()
        
        // 結果画面
        if isCaptured {
            isCaptured = false
            let view = fromStoryboard(clazz: ResultViewController.self)
            let rect = CGRect(x: CGFloat(touchPos.x - 50), y: CGFloat(touchPos.y - 50), width: CGFloat(Const.Capture.Width), height: CGFloat(Const.Capture.Height))
            view?.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            view?.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
            view?.tappedImage = trimmedImage(sourceImage: imageFromSampleBuffer(sampleBuffer: sampleBuffer), rect: rect)
            //view?.modalTransitionStyle = UIModalTransitionStyle.partialCurl
            self.present(view!, animated: true, completion: nil)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    fileprivate func displayCorporateLogo() {
        let label = UILabel(frame: CGRect(x: 20, y: Const.Screen.Size.height - 50, width: 100, height: 30))
        label.text = "IT-ai"
        label.textColor = Const.Color.CorporateLogo
        view.addSubview(label)
    }
    
    func tapGesture(touch: UITapGestureRecognizer) {
        print("touchPoint = \(touchPos)")
        touchPos = touch.location(in: self.view)
        isCaptured = true
    }
    
    private func trimmedImage(sourceImage: UIImage, rect: CGRect) -> UIImage? {
        guard let sourceImage = sourceImage.cgImage else { return nil }
        guard let trimmedImageRef = sourceImage.cropping(to: rect) else { return nil }
        return UIImage(cgImage: trimmedImageRef)
    }
    
    private func imageFromSampleBuffer(sampleBuffer :CMSampleBuffer) -> UIImage {
        let imageBuffer: CVImageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer)!
        CVPixelBufferLockBaseAddress(imageBuffer, CVPixelBufferLockFlags(rawValue: CVOptionFlags(0)))
        let baseAddress: UnsafeMutableRawPointer = CVPixelBufferGetBaseAddressOfPlane(imageBuffer, 0)!
        let bytesPerRow: UInt = UInt(CVPixelBufferGetBytesPerRow(imageBuffer))
        let width  = Int(CVPixelBufferGetWidth(imageBuffer))
        let height = Int(CVPixelBufferGetHeight(imageBuffer))
        let colorSpace: CGColorSpace = CGColorSpaceCreateDeviceRGB()
        let bitsPerCompornent: UInt = 8
        let bitmapInfo = CGBitmapInfo(rawValue: (CGBitmapInfo.byteOrder32Little.rawValue | CGImageAlphaInfo.premultipliedFirst.rawValue) as UInt32)
        let newContext: CGContext = CGContext(data: baseAddress, width: width, height: height, bitsPerComponent: Int(bitsPerCompornent), bytesPerRow: Int(bytesPerRow), space: colorSpace, bitmapInfo: bitmapInfo.rawValue)! as CGContext
        let imageRef: CGImage = newContext.makeImage()!
        let resultImage = UIImage(cgImage: imageRef, scale: 1.0, orientation: UIImageOrientation.right)
        return resultImage
    }
}
