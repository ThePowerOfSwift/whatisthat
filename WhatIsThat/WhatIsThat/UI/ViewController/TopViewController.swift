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

class TopViewController: UIViewController {
    @IBOutlet weak var transitionButton: UIButton!
    @IBOutlet weak var corporateLogoView: UIView!
    
    let transition = BubbleTransition()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 企業ロゴ
        corporateLogoView.layer.shadowColor = UIColor.white.cgColor
        
        // カメラビュー
        if let cameraView = fromXib(clazz: CameraView.self) {
            cameraView.delegate = self
            view.addSubview(cameraView)
            view.sendSubview(toBack: cameraView)
        }
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
    }
}

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
