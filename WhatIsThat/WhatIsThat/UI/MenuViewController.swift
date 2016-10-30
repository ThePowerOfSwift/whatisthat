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
    @IBOutlet weak var tableView: UITableView!
    
    let texts = ["お知らせ", "各種設定", "お問い合わせ", "利用規約", "プライバシーポリシー", "ライセンス", "バージョン"]
    
    override func viewDidLoad() {
        closeButton.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI_4))
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = UIColor.clear
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

extension MenuViewController: UITableViewDelegate, UITableViewDataSource {
    internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return texts.count
    }
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "Cell")
        cell.textLabel?.text = texts[indexPath.row]
        return cell
    }
    
    func tableView(_ table: UITableView, didSelectRowAt indexPath:IndexPath) {
        let vc = fromStoryboard(clazz: WebViewController.self)
        vc?.requestUrl = "https://google.co.jp"
        vc?.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        vc?.modalTransitionStyle   = UIModalTransitionStyle.crossDissolve
        self.present(vc!, animated: false, completion: nil)
    }
}
