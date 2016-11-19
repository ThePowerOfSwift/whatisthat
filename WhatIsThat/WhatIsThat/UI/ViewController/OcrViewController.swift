//
//  OcrViewController.swift
//  WhatIsThat
//
//  Created by 渡邊浩二 on 2016/11/17.
//  Copyright © 2016年 渡邊浩二. All rights reserved.
//

import UIKit

class OcrViewController: BaseTableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateData), name: Notification.Name(rawValue:"updateOcrData"), object: nil)
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
        let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height - 308), style: .plain)
        tableView.backgroundColor = UIColor.clear
        tableView.rowHeight = UITableViewAutomaticDimension
        return tableView
    }
    
    @objc func updateData() {
        let text = TextAnnotationTableViewDataSource()
        text.delegate = self
        self.addDataSource(dataSource: text)
        tableView?.reloadData()
    }
}
