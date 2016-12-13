//
//  SettingsViewController.swift
//  WhatIsThat
//
//  Created by 渡邊浩二 on 2016/11/22.
//  Copyright © 2016年 渡邊浩二. All rights reserved.
//

import UIKit

class SettingsViewController: BaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        addDataSources()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Hide navigation header
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func createTable() -> UITableView {
        let tableView = UITableView(frame: CGRect(x: 0, y: 84, width: view.frame.width, height: view.frame.height - 84 - 90), style: .plain)
        tableView.backgroundColor = UIColor.clear
        tableView.bounces = false
        return tableView
    }
    
    @IBAction func tappedBackButton(_ sender: UIButton) {
        _ = navigationController?.popViewController(animated: true)
    }
    
    func addDataSources() {
        addDataSource(dataSource: SettingItemTableViewDataSource())
        tableView?.reloadData()
    }
}
