//
//  TopicViewController.swift
//  WhatIsThat
//
//  Created by 渡邊浩二 on 2016/11/25.
//  Copyright © 2016年 渡邊浩二. All rights reserved.
//

import UIKit

class TopicViewController: BaseTableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        NotificationCenter.default.addObserver(self, selector: #selector(updateData), name: Notification.Name(rawValue:"updateRssData"), object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(reloadData), name: Notification.Name(rawValue:"reloadRssData"), object: nil)
        updateData()
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
        return tableView
    }
    
    @objc func updateData() {
        addDataSource(dataSource: TopicTableViewDataSource())
        tableView?.reloadData()
    }
    
    @objc func reloadData() {
        tableView?.reloadData()
    }
}

