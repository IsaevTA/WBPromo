//
//  SettingsAnalist.swift
//  SaleMarket
//
//  Created by Timur Isaev on 30.11.2020.
//

import Foundation

class SettingsAnalist {
    static let shared = SettingsAnalist()

    //For OneSignal
    let appId = "6f60d0a1-0b1c-4166-a75e-f169d99b37f3"
    
    //For Appsflyer
    let appsFlyerDevKey = "n26SE4JxyJMmjgoPBWTR4A"
    let appleAppID = "id1544444742"
    
    var wbInstalled: Bool {
        get { return UserDefaults.standard.bool(forKey: "WB_PRODUCT_INSTALLED") }
        set(newCenter) { UserDefaults.standard.set(newCenter, forKey: "WB_PRODUCT_INSTALLED") }
    }
    
    var firstStart: Bool {
        get { return UserDefaults.standard.bool(forKey: "WB_FISRT_START") }
        set(newCenter) { UserDefaults.standard.set(newCenter, forKey: "WB_FISRT_START") }
    }
    
    var firstStartForHelp: Bool {
        get { return UserDefaults.standard.bool(forKey: "WB_FISRT_START_FOR_HELP") }
        set(newCenter) { UserDefaults.standard.set(newCenter, forKey: "WB_FISRT_START_FOR_HELP") }
    }
}
