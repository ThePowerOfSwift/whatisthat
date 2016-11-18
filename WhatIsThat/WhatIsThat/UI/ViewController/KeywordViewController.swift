//
//  KeywordViewController.swift
//  WhatIsThat
//
//  Created by 渡邊浩二 on 2016/11/17.
//  Copyright © 2016年 渡邊浩二. All rights reserved.
//

import UIKit

class KeywordViewController: BaseTableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateData), name: Notification.Name(rawValue:"updateKeywordData"), object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    override func createTable() -> UITableView {
        let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height - 220), style: .plain)
        tableView.backgroundColor = UIColor.clear
        return tableView
    }
    
    @objc func updateData() {
        // Label
        let label = LabelAnnotationTableViewDataSource()
        label.delegate = self
        self.addDataSource(dataSource: label)
        
        // Logo
        let logo = LogoAnnotationTableViewDataSource()
        logo.delegate = self
        self.addDataSource(dataSource: logo)
        
        // Landmark
        let landmark = LandmarkAnnotationTableViewDataSource()
        landmark.delegate = self
        self.addDataSource(dataSource: landmark)
        
        // reloadData
        tableView?.reloadData()
    }
}
