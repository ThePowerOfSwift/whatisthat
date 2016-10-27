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
        
        // ジェスチャーの生成
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapGesture(touch:)))
        tap.numberOfTapsRequired = 1
        videoDisplayView.addGestureRecognizer(tap)
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
            self.cpsSession.sessionPreset = AVCaptureSessionPresetHigh
            
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
            print("screenSize=\(Const.Screen.Size)")
            print("drawFrame=\(drawFrame)")
            view?.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            view?.modalTransitionStyle   = UIModalTransitionStyle.crossDissolve
            guard let previewImage = UIImage.imageFromSampleBuffer(sampleBuffer: sampleBuffer)?.croppIngimage(toRect:drawFrame) else { return }
            let rect = getRect(withImage: previewImage)
            print("rect=\(rect)")
            view?.tappedImage = previewImage.croppIngimage(toRect: rect)
            //view?.modalTransitionStyle = UIModalTransitionStyle.partialCurl
            self.present(view!, animated: true, completion: nil)
        }
    }
    
    private func getDocumentsDirectory() -> URL? {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
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
        touchPos = touch.location(in: self.view)
        print("touchPoint = \(touchPos)")
        isCaptured = true
    }
    
    private func getRect(withImage image: UIImage) -> CGRect {
        let widthImage = UIImageView(image: image).frame.width
        let widthHalf  = CGFloat(Const.Capture.Width / 2)
        let heightHalf = CGFloat(Const.Capture.Height / 2)
        let scale  = widthImage / Const.Screen.Size.width
        let posX   = touchPos.x - widthHalf < 0 ? 0 : touchPos.x - widthHalf
        let posY   = touchPos.y - heightHalf < 0 ? 0 : touchPos.y - heightHalf
        let width  = touchPos.x + widthHalf - posX
        let height = touchPos.y + heightHalf - posY
        return CGRect(x:posY * scale, y: (CGFloat(Const.Screen.Size.width) - posX - CGFloat(Const.Capture.Width)) * scale, width: width * scale, height: height * scale)
    }
}
