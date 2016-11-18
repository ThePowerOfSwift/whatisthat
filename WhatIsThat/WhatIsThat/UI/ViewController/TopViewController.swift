//
//  TopViewController.swift
//  WhatIsThat
//
//  Created by 渡邊浩二 on 2016/10/13.
//  Copyright © 2016年 渡邊浩二. All rights reserved.
//

import BubbleTransition
import UIKit
import ObjectMapper
import Realm

protocol TopViewControllerDelegate {
    func gotoResultPage(captureImage: UIImage)
}

class TopViewController: UIViewController {
    @IBOutlet weak var corporateLogoView: UIView!
    @IBOutlet weak var transitionButton: UIButton!
    
    var cameraView = fromXib(class: CameraView.self)
    let transition = BubbleTransition()
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 企業ロゴ
        corporateLogoView.layer.shadowColor = UIColor.white.cgColor
        
        // カメラビュー
        if let cameraView = cameraView {
            cameraView.delegate = self
            view.addSubview(cameraView)
            view.sendSubview(toBack: cameraView)
        }
        
        // Photo Library
        imagePicker.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Clear DB
        RealmManager.deleteAll(CloudVisions.self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let controller = segue.destination
        controller.transitioningDelegate = self
        controller.modalPresentationStyle = .custom
    }
    
    @IBAction func tappedSnapShotButton(_ sender: UIButton) {
        cameraView?.isRequestCapture = true
    }
    
    @IBAction func tappedPhotoLibraryButton(_ sender: UIButton) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
}

// MARK: - UIViewControllerTransitioningDelegate
extension TopViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .present
        transition.startingPoint = transitionButton.center
        transition.bubbleColor = transitionButton.backgroundColor!
        return transition
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .dismiss
        transition.startingPoint = transitionButton.center
        transition.bubbleColor = transitionButton.backgroundColor!
        return transition
    }
}

// MARK: - UIImagePickerControllerDelegate
// MARK: - UINavigationControllerDelegate
extension TopViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        dismiss(animated: true, completion: nil)
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            gotoResultPage(captureImage: pickedImage)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - TopViewControllerDelegate
extension TopViewController: TopViewControllerDelegate {
    func gotoResultPage(captureImage: UIImage) {
        let vc = fromStoryboard(class: ResultViewController.self)
        vc?.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        vc?.modalTransitionStyle   = UIModalTransitionStyle.crossDissolve
        vc?.tappedImage = captureImage
        present(vc!, animated: true, completion: nil)
    }
}
