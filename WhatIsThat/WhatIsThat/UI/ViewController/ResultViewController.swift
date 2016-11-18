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
import PagingMenuController

private struct PagingMenuOptions: PagingMenuControllerCustomizable {
    var defaultPage = 1
    
    fileprivate var componentType: ComponentType {
        return .all(menuOptions: MenuOptions(), pagingControllers: pagingControllers)
    }
    
    fileprivate var pagingControllers: [UIViewController] {
        guard let ocr     = fromStoryboard(class: OcrViewController.self)     else { return [] }
        guard let keyword = fromStoryboard(class: KeywordViewController.self) else { return [] }
        guard let face    = fromStoryboard(class: FaceViewController.self)    else { return [] }
        return [ocr, keyword, face]
    }
    
    fileprivate struct MenuOptions: MenuViewCustomizable {
        var selectedBackgroundColor: UIColor {
            return UIColor(hex: 0xFFB98E, alpha: 1.0)
        }
        var height: CGFloat {
            return 40
        }
        var displayMode: MenuDisplayMode {
            return .segmentedControl
        }
        var itemsOptions: [MenuItemViewCustomizable] {
            return [MenuItem1(), MenuItem2(), MenuItem3()]
        }
        var animationDuration: TimeInterval {
            return 0.2
        }
        var focusMode: MenuFocusMode {
            return .underline(height: 4.0, color: UIColor.orange, horizontalPadding: 0.0, verticalPadding: 0.0)
        }
    }
    
    fileprivate struct MenuItem1: MenuItemViewCustomizable {
        var displayMode: MenuItemDisplayMode {
            return .text(title: MenuItemText(text: "OCR", color: UIColor.lightGray, selectedColor: UIColor.orange, font: UIFont.systemFont(ofSize: 16), selectedFont: UIFont.boldSystemFont(ofSize: 16)))
        }
    }
    fileprivate struct MenuItem2: MenuItemViewCustomizable {
        var displayMode: MenuItemDisplayMode {
            return .text(title: MenuItemText(text: "キーワード", color: UIColor.lightGray, selectedColor: UIColor.orange, font: UIFont.systemFont(ofSize: 16), selectedFont: UIFont.boldSystemFont(ofSize: 16)))
        }
    }
    fileprivate struct MenuItem3: MenuItemViewCustomizable {
        var displayMode: MenuItemDisplayMode {
            return .text(title: MenuItemText(text: "顔検出", color: UIColor.lightGray, selectedColor: UIColor.orange, font: UIFont.systemFont(ofSize: 16), selectedFont: UIFont.boldSystemFont(ofSize: 16)))
        }
    }
}

class ResultViewController: UIViewController {
    @IBOutlet weak var loadingVIew: UIView!

    let headerView  = fromXib(class: SimpleImageView.self)
    var tappedImage: UIImage? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Header
        createHeaderView()
        
        // PageMenu
        createPageMenu()
        
        // Loading Indicator
        view.bringSubview(toFront: loadingVIew)

        // API Request
        loadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func createHeaderView() {
        if let headerView = headerView {
            headerView.mainImage = tappedImage
            headerView.delegate = self
            view.addSubview(headerView)
        }
    }
    
    func createPageMenu() {
        let options = PagingMenuOptions()
        let pagingMenuController = PagingMenuController(options: options)
        pagingMenuController.delegate = self
        let headerHeight = headerView?.frame.size.height ?? 0
        pagingMenuController.view.frame.origin.y += headerHeight
        pagingMenuController.view.frame.size.height -= headerHeight
        
        addChildViewController(pagingMenuController)
        view.addSubview(pagingMenuController.view)
        pagingMenuController.didMove(toParentViewController: self)
    }
    
    func loadData() {
        guard let tappedImage = tappedImage else { return }
        
        loadingVIew.isHidden = false
        CloudVisionManager().getData(image: tappedImage) { (response) in
            switch response {
            case .success:
                debugPrint("API request is succeeded.")
                let nc = NotificationCenter.default
                nc.post(name: Notification.Name(rawValue:"updateKeywordData"), object: nil)
                nc.post(name: Notification.Name(rawValue:"updateOcrData"), object: nil)
                nc.post(name: Notification.Name(rawValue:"updateFaceData"), object: nil)
            case .failure(let error):
                debugPrint(error)
                self.showAlert()
            }
            self.loadingVIew.isHidden = true
        }
    }
    
    func showAlert() {
        let alert = UIAlertController(
            title: "通信エラー",
            message: "データの取得に失敗しました。\n\n電波状況をお確かめの上、\n再度ご利用ください。",
            preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "リトライ",
                                      style: .default,
                                      handler:{ action in
            self.loadData()
        }))
        alert.addAction(UIAlertAction(title: "戻る",
                                      style: .cancel,
                                      handler:{ action in
            self.dismiss(animated: false, completion: nil)
        }))
        present(alert, animated: true, completion: nil)
    }
}

extension ResultViewController: SimpleImageViewDelegate {
    func tappedCancelButton() {
        dismiss(animated: false, completion: nil)
    }
}

extension ResultViewController: PagingMenuControllerDelegate {
    // MARK: - PagingMenuControllerDelegate
    func willMove(toMenu menuController: UIViewController, fromMenu previousMenuController: UIViewController) {
        print(#function)
        print(previousMenuController)
        print(menuController)
    }
    
    func didMove(toMenu menuController: UIViewController, fromMenu previousMenuController: UIViewController) {
        print(#function)
        print(previousMenuController)
        print(menuController)
    }
    
    func willMove(toMenuItem menuItemView: MenuItemView, fromMenuItem previousMenuItemView: MenuItemView) {
        print(#function)
        print(previousMenuItemView)
        print(menuItemView)
    }
    
    func didMove(toMenuItem menuItemView: MenuItemView, fromMenuItem previousMenuItemView: MenuItemView) {
        print(#function)
        print(previousMenuItemView)
        print(menuItemView)
    }
}
