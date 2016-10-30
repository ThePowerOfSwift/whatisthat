//
//  ResultViewController.swift
//  WhatIsThat
//
//  Created by 渡邊浩二 on 2016/10/16.
//  Copyright © 2016年 渡邊浩二. All rights reserved.
//

import UIKit
import MapKit

class ResultViewController: UIViewController {
    @IBOutlet weak var tappedImageView: UIImageView!
    @IBOutlet weak var result: UILabel!
    
    var tappedImage: UIImage? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tappedImageView.image = tappedImage
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let image = self.tappedImage {
            tappedImageView.image = image
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func tappedBackgroundView(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
