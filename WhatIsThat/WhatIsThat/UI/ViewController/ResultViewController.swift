//
//  ResultViewController.swift
//  WhatIsThat
//
//  Created by 渡邊浩二 on 2016/10/16.
//  Copyright © 2016年 渡邊浩二. All rights reserved.
//

import CoreLocation
import ObjectMapper
import RealmSwift
import UIKit
import PagingMenuController

protocol ResultViewControllerDelegate: class {
    func gotoWeatherPage()
}

class ResultViewController: UIViewController {
    @IBOutlet weak var loadingView: UIView!

    let headerView = fromXib(class: ResultHeaderView.self)
    var locationManager: CLLocationManager?
    var tappedImage: UIImage? = nil
    var isShownWeatherButton: Bool = false
    var latitude: Double?
    var longitude: Double?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Header
        createHeaderView()
        
        // PageMenu
        createPageMenu()
        
        // Loading Indicator
        view.bringSubview(toFront: loadingView)

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
        
        loadingView.isHidden = false
        CloudVisionManager().getData(image: tappedImage) { [weak self] (response) in
            switch response {
            case .success:
                print("Cloud vision API request is succeeded.")
                let nc = NotificationCenter.default
                nc.post(name: Notification.Name(rawValue:"updateKeywordData"), object: nil)
                nc.post(name: Notification.Name(rawValue:"updateOcrData"), object: nil)
                nc.post(name: Notification.Name(rawValue:"updateFaceData"), object: nil)
                self?.showSafeSearchRate()
                self?.showWeatherButtonIfNeeded()
            case .failure(let error):
                print(error)
                self?.showAlert()
            }
            self?.loadingView.isHidden = true
        }
    }
    
    func showSafeSearchRate() {
        guard let safeSearchAnnotation = RealmManager.get(CloudVisions.self, key: 0)?.responses.first?.safeSearchAnnotation else { return }
        var safeRate = 0
        if let adult = SafeSearchLikelyHood(rawValue: safeSearchAnnotation.adult) {
            let adultRate = adult.toScore()
            safeRate += adultRate
            headerView?.adultRate = adultRate
        }
        if let spoof = SafeSearchLikelyHood(rawValue: safeSearchAnnotation.spoof) {
            safeRate += spoof.toScore()
        }
        if let medical = SafeSearchLikelyHood(rawValue: safeSearchAnnotation.medical) {
            safeRate += medical.toScore()
        }
        if let violence = SafeSearchLikelyHood(rawValue: safeSearchAnnotation.violence) {
            safeRate += violence.toScore()
        }
        headerView?.safeRate = safeRate * 5
    }
    
    private func isNeedShowWeatherButton() -> Bool {
        var result = false
        let lists = RealmManager.get(CloudVisions.self, key: 0)?.responses.first?.labelAnnotations
        lists?.forEach({ (list) in
            let keyword = list.note.lowercased()
            if keyword == "sky" || keyword == "blue" {
                result = true
                return
            }
        })
        return result
    }
    
    func showWeatherButton() {
        guard isShownWeatherButton == false else { return }
        guard let latitude  = self.latitude else { return }
        guard let longitude = self.longitude else { return }
        isShownWeatherButton = true
        WeatherMapManager().getData(latitude: latitude, longitude: longitude) { (response) in
            switch response {
            case .success:
                print("WeatherMap API request is succeeded.")
                let nc = NotificationCenter.default
                nc.post(name: Notification.Name(rawValue:"showWeatherIcon"), object: nil)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func showWeatherButtonIfNeeded() {
        guard isNeedShowWeatherButton() else { return }
        // 天気ボタンを表示
        if UserDefaults.standard.isUseLocationFromImage && latitude != nil && longitude != nil {
            // 画像から位置情報を取得
            showWeatherButton()
        } else if UserDefaults.standard.isUseLocationFromDevice {
            // 端末から位置情報を取得
            locationManager = CLLocationManager()
            locationManager?.delegate = self
            locationManager?.desiredAccuracy = kCLLocationAccuracyThreeKilometers
            locationManager?.requestWhenInUseAuthorization()
            locationManager?.startUpdatingLocation()
        }
    }
    
    private func showAlert() {
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

extension ResultViewController: ResultViewControllerDelegate {
    func gotoWeatherPage() {
        guard let vc = fromStoryboard(class: WeatherViewController.self) else { return }
        vc.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        vc.modalTransitionStyle   = UIModalTransitionStyle.crossDissolve
        vc.tappedImage = tappedImage
        vc.latitude    = latitude
        vc.longitude   = longitude
        UIApplication.shared.topViewController?.present(vc, animated: true, completion: nil)
    }
}

extension ResultViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        latitude  = manager.location?.coordinate.latitude
        longitude = manager.location?.coordinate.longitude
        locationManager?.stopUpdatingLocation()
        showWeatherButton()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error){
        print("error")
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

private struct PagingMenuOptions: PagingMenuControllerCustomizable {
    var defaultPage = 1
    
    fileprivate var componentType: ComponentType {
        return .all(menuOptions: MenuOptions(), pagingControllers: pagingControllers)
    }
    
    fileprivate var pagingControllers: [UIViewController] {
        guard let ocr = fromStoryboard(class: OcrViewController.self) else { return [] }
        guard let keyword = fromStoryboard(class: KeywordViewController.self) else { return [] }
        guard let face = fromStoryboard(class: FaceViewController.self) else { return [] }
        return [ocr, keyword, face]
    }
    
    fileprivate struct MenuOptions: MenuViewCustomizable {
        var selectedBackgroundColor: UIColor {
            return Const.Color.BackGroundLightAccent
        }
        var height: CGFloat {
            return 58
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
            return .underline(height: 4.0, color: Const.Color.MenuItemTitleBorder, horizontalPadding: 0.0, verticalPadding: 0.0)
        }
    }
    
    fileprivate struct MenuItem1: MenuItemViewCustomizable {
        var displayMode: MenuItemDisplayMode {
            return .text(title: MenuItemText(text: "OCR", color: Const.Color.MenuItemText, selectedColor: Const.Color.MenuItemTitle, font: UIFont.boldSystemFont(ofSize: 12), selectedFont: UIFont.boldSystemFont(ofSize: 12)))
        }
    }
    
    fileprivate struct MenuItem2: MenuItemViewCustomizable {
        var displayMode: MenuItemDisplayMode {
            return .text(title: MenuItemText(text: "キーワード", color: Const.Color.MenuItemText, selectedColor: Const.Color.MenuItemTitle, font: UIFont.boldSystemFont(ofSize: 12), selectedFont: UIFont.boldSystemFont(ofSize: 12)))
        }
    }
    
    fileprivate struct MenuItem3: MenuItemViewCustomizable {
        var displayMode: MenuItemDisplayMode {
            return .text(title: MenuItemText(text: "人物", color: Const.Color.MenuItemText, selectedColor: Const.Color.MenuItemTitle, font: UIFont.boldSystemFont(ofSize: 12), selectedFont: UIFont.boldSystemFont(ofSize: 12)))
        }
    }
}
