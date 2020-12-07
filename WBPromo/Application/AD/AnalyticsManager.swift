//
//  AnalyticsManadger.swift
//  WBPromo
//
//  Created by Timur Isaev on 30.11.2020.
//

import UIKit
import Foundation
import AppsFlyerLib

class AnalyticsManager {
    
    static var shared = AnalyticsManager()
    
    //MARK: - AppsFlyer
    
    func featchDeepLinkAppsFlyer(withData data: [AnyHashable : Any], andView view: UIView) {
        print(data)
        
        if let idProduct = data["id_wb_product"] as? Int {
            NotificationCenter.default.post(name: NSNotification.Name("OpenPromo"), object: nil, userInfo: ["idPromo": idProduct])
        }
        
//        if let status = data["af_status"] as? String {
//            if(status == "Non-organic") {
//                print("onConversionDataSuccess data:")
//                let tempData = data as! [String: Any]
//                if let theJSONData = try? JSONSerialization.data(withJSONObject: tempData, options: .prettyPrinted), let theJSONText = String(data: theJSONData, encoding: String.Encoding.ascii) {
//                    print(theJSONText)
//
//                }
//            }
//        }
    }
}
