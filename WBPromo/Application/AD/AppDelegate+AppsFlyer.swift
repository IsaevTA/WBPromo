//
//  AppDelegate+AppsFlyer.swift
//  WBPromo
//
//  Created by Timur Isaev on 30.11.2020.
//

import UIKit
import AppsFlyerLib

extension AppDelegate: AppsFlyerLibDelegate {

    func applicationDidBecomeActive(_ application: UIApplication) {
        AppsFlyerLib.shared().start()
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) {
        AppsFlyerLib.shared().handlePushNotification(userInfo)
    }

    private func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([Any]?) -> Void) -> Bool {
        AppsFlyerLib.shared().continue(userActivity, restorationHandler: restorationHandler)
        return true
    }

    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        AppsFlyerLib.shared().handleOpen(url, sourceApplication: sourceApplication, withAnnotation: annotation)
        return true
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        AppsFlyerLib.shared().handleOpen(url, options: options)
        return true
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        AppsFlyerLib.shared().handlePushNotification(userInfo)
    }

    func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
        AppsFlyerLib.shared().continue(userActivity, restorationHandler: nil)
        return true
    }
    
    func onConversionDataSuccess(_ installData: [AnyHashable: Any]) {
        print(installData)
        
        AnalyticsManager.shared.featchDeepLinkAppsFlyer(withData: installData, andView: (window?.rootViewController?.view)!)
    }
    
    func onConversionDataFail(_ error: Error) {
        print(error)
    }
    
    func onAppOpenAttribution(_ attributionData: [AnyHashable : Any]) {
    }
    
    func onAppOpenAttributionFailure(_ error: Error) {
        print(error)
    }
}
