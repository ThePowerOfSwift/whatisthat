//
//  CameraView.swift
//  WhatIsThat
//
//  Created by 渡邊浩二 on 2016/10/30.
//  Copyright © 2016年 渡邊浩二. All rights reserved.
//

import UIKit
import GLKit
import AVFoundation

class CameraView: UIView {
    var delegate: TopViewControllerDelegate?
    var videoDisplayView: GLKView!
    var videoDisplayViewRect: CGRect!
    var renderContext: CIContext!
    var cpsSession: AVCaptureSession!
    var isRequestCapture: Bool = false
    var isScreenTapped: Bool = false
    var touchPos = CGPoint(x: 0, y: 0)

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        setUp()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    private func setUp() {
        frame = CGRect(x: 0, y: 0, width: Const.Screen.Size.width, height: Const.Screen.Size.height)
        initDisplay()
        initCamera()
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapGesture(touch:)))
        tap.numberOfTapsRequired = 1
        addGestureRecognizer(tap)
    }
    
    override func willRemoveSubview(_ subview: UIView) {
        // カメラの停止とメモリ解放
        cpsSession.stopRunning()
        for output in cpsSession.outputs {
            cpsSession.removeOutput(output as! AVCaptureOutput)
        }
        
        for input in cpsSession.inputs {
            cpsSession.removeInput(input as! AVCaptureInput)
        }
        cpsSession = nil
    }
    
    // 画面の生成
    private func initDisplay() {
        videoDisplayView = GLKView(frame: self.bounds, context: EAGLContext(api: .openGLES2))
        videoDisplayView.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI_2))
        videoDisplayView.frame = self.bounds
        self.addSubview(videoDisplayView)
        
        renderContext = CIContext(eaglContext: videoDisplayView.context)
        videoDisplayView.bindDrawable()
        videoDisplayViewRect = CGRect(x: 0, y: 0, width: videoDisplayView.drawableWidth, height: videoDisplayView.drawableHeight)
        
        // ジェスチャーの生成
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapGesture(touch:)))
        tap.numberOfTapsRequired = 1
        videoDisplayView.addGestureRecognizer(tap)
    }
    
    // カメラの使用準備
    private func initCamera() {
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
            if (cpsSession.canAddInput(deviceInput)) {
                cpsSession.addInput(deviceInput as AVCaptureDeviceInput)
            }
            // Output
            if (cpsSession.canAddOutput(videoDataOutput)) {
                cpsSession.addOutput(videoDataOutput)
            }
            //解像度の指定
            cpsSession.sessionPreset = AVCaptureSessionPresetHigh
            cpsSession.startRunning()
        } catch (let error) {
            print(error)
        }
    }
    
    private func getDocumentsDirectory() -> URL? {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
    }
    
    func tapGesture(touch: UITapGestureRecognizer) {
        touchPos = touch.location(in: self)
        print("touchPoint = \(touchPos)")
        isScreenTapped   = true
        isRequestCapture = true
    }
}

extension CameraView: AVCaptureVideoDataOutputSampleBufferDelegate {
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
        if isRequestCapture {
            isRequestCapture = false
            print("screenSize=\(Const.Screen.Size)")
            print("drawFrame=\(drawFrame)")
            guard let previewImage = UIImage.imageFromSampleBuffer(sampleBuffer: sampleBuffer)?.croppingImage(toRect:drawFrame) else { return }
            
            if isScreenTapped,
                let previewImage = previewImage.croppingImage(toRect: getRect(withImage: previewImage)) {
                delegate?.gotoResultPage(captureImage: previewImage)
                isScreenTapped = false
            } else {
                delegate?.gotoResultPage(captureImage: previewImage)
            }
        }
    }
    
    func getRect(withImage image: UIImage) -> CGRect {
        let widthImage = UIImageView(image: image).frame.width
        let heightHalf = CGFloat(Const.Capture.Height / 2)
        let widthHalf  = CGFloat(Const.Capture.Width / 2)
        let scale  = widthImage / Const.Screen.Size.width
        let posX   = touchPos.x - heightHalf < 0 ? 0 : touchPos.x - heightHalf
        let posY   = touchPos.y - widthHalf < 0 ? 0 : touchPos.y - widthHalf
        let width  = touchPos.x + heightHalf - posX
        let height = touchPos.y + widthHalf - posY
        return CGRect(x:posY * scale, y: (CGFloat(Const.Screen.Size.width) - posX - CGFloat(Const.Capture.Height)) * scale, width: width * scale, height: height * scale)
    }
}
