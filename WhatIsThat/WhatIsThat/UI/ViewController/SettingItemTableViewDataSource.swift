//
//  SettingItemTableViewDataSource.swift
//  WhatIsThat
//
//  Created by 渡邊浩二 on 2016/11/23.
//  Copyright © 2016年 渡邊浩二. All rights reserved.
//

import UIKit

class SettingItemTableViewDataSource: NSObject, BaseTableViewDataSource {
    internal var viewClasses: [UITableViewCell.Type]? = [SettingItemTableViewCell.self]
    
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(className: SettingItemTableViewCell.self, indexPath: indexPath)
        var title: String = ""
        var note:  String = ""
        var isOn:  Bool   = false
        
        if indexPath.row == 0 {
            title = "自動翻訳を利用する"
            note  = "画像解析の結果を自動翻訳します。\n端末からの位置情報を優先して利用されます。"
            isOn  = UserDefaults.standard.isUseAutoTranstate
        } else if indexPath.row == 1 {
            title = "PhotoLibraryから位置情報を取得"
            note  = "PhoroLiraryの画像に埋め込まれた位置情報から場所を特定し、その場所の天気を表示します。"
            isOn  = UserDefaults.standard.isUseLocationFromImage
        } else if indexPath.row == 2 {
            title = "端末から位置情報を取得"
            note  = "位置情報から場所を特定し、その場所の天気を表示します。"
            isOn  = UserDefaults.standard.isUseLocationFromDevice
        }
        
        cell.tag      = indexPath.row
        cell.delegate = self
        cell.title    = title
        cell.note     = note
        cell.isOn     = isOn
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(150)
    }
}

extension SettingItemTableViewDataSource: SettingItemTableViewCellDelegate {
    func updateSetting(tag: Int, isOn: Bool) {
        if tag == 0 {
            UserDefaults.standard.isUseAutoTranstate = isOn
        } else if tag == 1 {
            UserDefaults.standard.isUseLocationFromImage = isOn
        } else if tag == 2 {
            UserDefaults.standard.isUseLocationFromDevice = isOn
        }
    }
}
