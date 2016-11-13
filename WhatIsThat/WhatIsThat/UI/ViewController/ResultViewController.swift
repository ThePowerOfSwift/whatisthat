//
//  ResultViewController.swift
//  WhatIsThat
//
//  Created by 渡邊浩二 on 2016/10/16.
//  Copyright © 2016年 渡邊浩二. All rights reserved.
//

import ObjectMapper
import RealmSwift
import UIKit

class ResultViewController: BaseTableViewController {
    let loadingView = fromXib(clazz: LoadingView.self)
    var tappedImage: UIImage? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadingView?.show()
        CloudVisionManager().getData(image: tappedImage!) { (response) in
            switch response {
            case .success:
                debugPrint("API request is succeeded.")
                let datasource = ResultTableViewDataSource()
                datasource.delegate = self
                self.addDataSource(dataSource: datasource)
                self.tableView?.reloadData()
            case .failure(let error):
                debugPrint(error)
            }
            self.loadingView?.hide()
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

