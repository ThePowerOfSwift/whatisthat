//
//  MenuViewController.swift
//  WhatIsThat
//
//  Created by 渡邊浩二 on 2016/10/28.
//  Copyright © 2016年 渡邊浩二. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {

    @IBOutlet weak var closeButton: UIButton!
    
    override func viewDidLoad() {
        closeButton.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI_4))
    }
    
    @IBAction func closeAction(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        UIApplication.shared.setStatusBarStyle(.lightContent, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        UIApplication.shared.setStatusBarStyle(.default, animated: true)
    }
}
