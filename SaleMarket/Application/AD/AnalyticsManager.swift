//
//  AnalyticsManadger.swift
//  SaleMarket
//
//  Created by Timur Isaev on 30.11.2020.
//

import UIKit
import Foundation
import AppsFlyerLib

class AnalyticsManager {
    
    static var shared = AnalyticsManager()
    
    //MARK: - AppsFlyer
    func featchDeepLinkAppsFlyer(withData data: [AnyHashable : Any]) {
        print(data)
        
        if let idProduct = data["id_wb_product"] as? Int {
            NotificationCenter.default.post(name: NSNotification.Name("OpenProduct"), object: nil, userInfo: ["idProduct": idProduct])
        }
    }
}
