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

class TopViewController: UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate
{
    var videoDisplayView: GLKView!
    var videoDisplayViewRect: CGRect!
    var renderContext: CIContext!
    var cpsSession: AVCaptureSession!
    
    override func viewWillAppear(_ animated: Bool) {
        //画面の生成
        self.initDisplay()
        
        // カメラの使用準備.
        self.initCamera()
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
}
