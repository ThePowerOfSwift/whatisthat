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
import Photos

protocol TopViewControllerDelegate: class {
    func gotoResultPage(captureImage: UIImage)
}

class TopViewController: UIViewController {    @IBOutlet weak var transitionButton: UIButton!
    
    var cameraView = fromXib(class: CameraView.self)
    let transition = BubbleTransition()
    let imagePicker = UIImagePickerController()
    var latitude: Double?
    var longitude: Double?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Clear DB
        RealmManager.deleteAll(CloudVisions.self)
        RealmManager.deleteAll(Translates.self)
        
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
        guard picker.sourceType == UIImagePickerControllerSourceType.photoLibrary else { return }
        getLocationFromPhotoLibrary(info: info)
        
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            dismiss(animated: true, completion: nil)
            gotoResultPage(captureImage: pickedImage)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    private func getLocationFromPhotoLibrary(info: [String : Any]) {
        guard UserDefaults.standard.isUseLocationFromImage else { return }
        guard let url = info[UIImagePickerControllerReferenceURL] as? URL else { return }
        print("photo url=\(url)")
        let fetchResult = PHAsset.fetchAssets(withALAssetURLs: [url], options: nil)
        let asset = fetchResult.firstObject
        let coordinate = asset?.location
        print("photo coordinate=\(coordinate)")
        longitude = coordinate?.coordinate.longitude
        latitude  = coordinate?.coordinate.latitude
    }
}

// MARK: - TopViewControllerDelegate
extension TopViewController: TopViewControllerDelegate {
    func gotoResultPage(captureImage: UIImage) {
        guard let vc = fromStoryboard(class: ResultViewController.self) else { return }
        vc.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        vc.modalTransitionStyle   = UIModalTransitionStyle.crossDissolve
        vc.tappedImage = captureImage
        vc.longitude = longitude
        vc.latitude = latitude
        present(vc, animated: true, completion: nil)
    }
}
