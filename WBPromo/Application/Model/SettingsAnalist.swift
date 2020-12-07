//
//  SettingsAnalist.swift
//  WBPromo
//
//  Created by Timur Isaev on 30.11.2020.
//

import Foundation

class SettingsAnalist {
    static let shared = SettingsAnalist()

    //For OneSignal
    let appId = "8b32ed7c-8a12-44e7-a671-a9d6bc1ed32d"
    
    //For Appsflyer
    let appsFlyerDevKey = "n26SE4JxyJMmjgoPBWTR4A"
    let appleAppID = "id1543203177"
    
    var wbInstalled: Bool {
        get { return UserDefaults.standard.bool(forKey: "WB_PROMO_INSTALLED") }
        set(newCenter) { UserDefaults.standard.set(newCenter, forKey: "WB_PROMO_INSTALLED") }
    }
}
