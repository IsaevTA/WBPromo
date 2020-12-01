//
//  AnalyticsManadger.swift
//  WBPromo
//
//  Created by Timur Isaev on 30.11.2020.
//

import UIKit
import Foundation
import OneSignal
import AppsFlyerLib

class AnalyticsManager {
    
    static var shared = AnalyticsManager()

    let globalSettings = GlobalSettings.shared
    let webView = WebView.shared

    let settingAnalyst = SettingsAnalist.shared
    
    //MARK: - OneSignal
    func setupOneSignal(launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
        let onesignalInitSettings = [kOSSettingsKeyAutoPrompt: false, kOSSettingsKeyInAppLaunchURL: false]
        OneSignal.initWithLaunchOptions(launchOptions,
                                        appId: settingAnalyst.appId,
                                        handleNotificationAction: nil,
                                        settings: onesignalInitSettings)

        OneSignal.inFocusDisplayType = OSNotificationDisplayType.notification;
        OneSignal.promptForPushNotifications(userResponse: { accepted in
            print("User accepted notifications: \(accepted)")
        })
    }
    
    //MARK: - AppsFlyer
    
    func featchDeepLinkAppsFlyer(withData data: [AnyHashable : Any], andView view: UIView) {
        if let status = data["af_status"] as? String {
            if(status == "Non-organic") {
                print("onConversionDataSuccess data:")
                let tempData = data as! [String: Any]
                if let theJSONData = try? JSONSerialization.data(withJSONObject: tempData, options: .prettyPrinted), let theJSONText = String(data: theJSONData, encoding: String.Encoding.ascii) {
                    print(theJSONText)
                    
                    globalSettings.urlProduct = "sdjkh idfhgd;sfilhgidf"
                    
                    webView.showWebView(withURL: "fdgdfg dfgdf", andView: view)
//                    showInfoAboutProduct(withURL: "fdgdfg dfgdf", andView: view)
                }
            }
        }
    }
}
