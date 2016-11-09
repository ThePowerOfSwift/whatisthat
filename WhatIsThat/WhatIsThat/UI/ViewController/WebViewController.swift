//
//  WebViewController.swift
//  WhatIsThat
//
//  Created by 渡邊浩二 on 2016/10/29.
//  Copyright © 2016年 渡邊浩二. All rights reserved.
//

import UIKit
import SafariServices

class WebViewController: UIViewController {
    var isShowed: Bool = false
    var requestUrl: String? = nil
    
    override func viewDidAppear(_ animated: Bool) {
        guard let requestUrl = self.requestUrl, isShowed == false else {
            return
        }
        
        let vc = SFSafariViewController(url: URL(string: requestUrl)!)
        vc.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        vc.modalTransitionStyle   = UIModalTransitionStyle.crossDissolve
        vc.delegate = self
        present(vc, animated: true, completion: nil)
    }
}

extension WebViewController: SFSafariViewControllerDelegate {
    func safariViewController(_ controller: SFSafariViewController, activityItemsFor URL: URL, title: String?) -> [UIActivity] {
        return [UIActivity()]
    }
    
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        debugPrint("safariViewControllerDidFinish:")
        dismiss(animated: false, completion: nil)
    }
    
    func safariViewController(_ controller: SFSafariViewController, didCompleteInitialLoad didLoadSuccessfully: Bool) {
        isShowed = true
        debugPrint("safariViewController:didCompleteInitialLoad:")
    }
}
