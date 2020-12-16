//
//  TabBarViewController.swift
//  SaleMarket
//
//  Created by UserDev on 15.12.2020.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
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
}
