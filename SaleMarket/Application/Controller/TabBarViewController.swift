//
//  TabBarViewController.swift
//  SaleMarket
//
//  Created by Timur Isaev on 15.12.2020.
//

import UIKit
import AppsFlyerLib

class TabBarViewController: UITabBarController {

    private let appURL = "SaleMarket://"
    private let groupName = "group.SaleMarket"
//    private let wbProductName = "WB_PRODUCT_NAME"
    private let wbProductUrl = "WB_PRODUCT_URL"
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNotification()
        setupCenterButton()
    }

//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        self.view.bringSubviewToFront(self.tabBar)
//        self.addCenterButton()
//    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        self.setUrl()
    }
    
    override func viewWillLayoutSubviews() {
        let numberOfItems = CGFloat(tabBar.items!.count)
        let tabBarItemSize = CGSize(width: tabBar.frame.width / numberOfItems, height: tabBar.frame.height)
        
        tabBar.selectionIndicatorImage = UIImage.imageWithColor(color: UIColor.white, size: tabBarItemSize).resizableImage(withCapInsets: .zero)
        
        if #available(iOS 13, *) {
            let appearance = UITabBarAppearance()
            appearance.stackedLayoutAppearance.normal.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(red: 0.487, green: 0.448, blue: 0.538, alpha: 1)]
            appearance.stackedLayoutAppearance.selected.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(red: 0.491, green: 0, blue: 0.722, alpha: 1)]
            tabBar.standardAppearance = appearance
        } else {
            let appearance = UITabBarItem.appearance(whenContainedInInstancesOf: [TabBarViewController.self])
            appearance.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor(red: 0.487, green: 0.448, blue: 0.538, alpha: 1)],
                                              for: .normal)
            appearance.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor(red: 0.491, green: 0, blue: 0.722, alpha: 1)],
                                              for: .selected)
        }
    }
    
    func setupNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(setUrl), name: UIApplication.didBecomeActiveNotification, object: nil)
    }
    
    @objc func setUrl() {
        if let url = UserDefaults(suiteName: self.groupName)?.value(forKey: self.wbProductUrl) as? String {
            print("setUrl - \(url)")
            CoreDataManager.shared.saveWBProduct(withUrlProduct: url)
            UserDefaults(suiteName: groupName)?.set(nil, forKey: self.wbProductUrl)
            UserDefaults(suiteName: groupName)?.removeObject(forKey: self.wbProductUrl)
            NotificationCenter.default.post(name: NSNotification.Name("UpdateTable"), object: nil)
        }
    }
    
    // MARK: - AddButton
    func setupCenterButton() {
        let centerButton = UIButton(frame: CGRect(x: 0, y: 10, width: 40, height: 40))

        let tabbarview = self.tabBar.frame
        var centerButtonFrame = centerButton.frame
        centerButtonFrame.origin.y = (tabbarview.height - centerButtonFrame.height) - 2
        centerButtonFrame.origin.x = (tabbarview.width / 2) - (centerButtonFrame.size.width / 2)
        centerButton.frame = centerButtonFrame
        centerButton.setBackgroundImage(#imageLiteral(resourceName: "wb"), for: .normal)
        centerButton.layer.cornerRadius = 5
        centerButton.addTarget(self, action: #selector(didTouchCenterButton(_:)), for: .touchUpInside)

        self.tabBar.addSubview(centerButton)
        self.view.bringSubviewToFront(centerButton)

        view.layoutIfNeeded()
    }

    // MARK: - Center button Actions
    @objc private func didTouchCenterButton(_ sender: AnyObject) {

        let appScheme = "wildberries://"
        let appUrl = URL(string: appScheme)

        if UIApplication.shared.canOpenURL(appUrl! as URL){
            //Приложение установлено
            UIApplication.shared.open(appUrl!)
        } else {
            let appScheme = "https://www.wildberries.ru"
            let appUrl = URL(string: appScheme)
            UIApplication.shared.open(appUrl!)
        }
    }
}
