//
//  SettingItemTableViewCell.swift
//  WhatIsThat
//
//  Created by 渡邊浩二 on 2016/11/23.
//  Copyright © 2016年 渡邊浩二. All rights reserved.
//

import UIKit
import PaperSwitch

protocol SettingItemTableViewCellDelegate: class {
    func updateSetting(tag: Int, isOn: Bool)
}

class SettingItemTableViewCell: UITableViewCell {
    @IBOutlet weak var paperSwitch: RAMPaperSwitch!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var noteLabel: UILabel!
    
    var delegate: SettingItemTableViewCellDelegate?
    var isOn: Bool = false {
        didSet {
            paperSwitch.isOn = isOn
        }
    }
    var title = "" {
        didSet {
            titleLabel.text = title
        }
    }
    var note = "" {
        didSet {
            noteLabel.text = note
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        paperSwitch.animationDidStartClosure = {(onAnimation: Bool) in
            UIView.transition(with: self.titleLabel, duration: self.paperSwitch.duration, options: UIViewAnimationOptions.transitionCrossDissolve, animations:
                {
                    self.titleLabel.textColor = onAnimation ? Const.Color.MenuItemAccent : Const.Color.MenuItemText
                }, completion: { (_) in
                    self.delegate?.updateSetting(tag: self.tag, isOn: self.paperSwitch.isOn)
                }
            )
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
