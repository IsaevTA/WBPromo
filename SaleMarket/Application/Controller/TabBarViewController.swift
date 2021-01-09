//
//  TabBarViewController.swift
//  SaleMarket
//
//  Created by Timur Isaev on 15.12.2020.
//

import UIKit

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
    }

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
            self.showAlert(withTitle: "URL", withMessage: url)
            UserDefaults(suiteName: groupName)?.set(nil, forKey: self.wbProductUrl)
            UserDefaults(suiteName: groupName)?.removeObject(forKey: self.wbProductUrl)
        }
    }
}
