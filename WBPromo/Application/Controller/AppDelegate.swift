//
//  AppDelegate.swift
//  WBPromo
//
//  Created by Timur Isaev on 27.11.2020.
//

import UIKit
import OneSignal
import AppsFlyerLib

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    let settingAnalyst = SettingsAnalist.shared
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let onesignalInitSettings = [kOSSettingsKeyAutoPrompt: false, kOSSettingsKeyInAppLaunchURL: false]
        OneSignal.initWithLaunchOptions(launchOptions,
                                        appId: settingAnalyst.appId,
                                        handleNotificationAction: nil,
                                        settings: onesignalInitSettings)

        OneSignal.inFocusDisplayType = OSNotificationDisplayType.notification;
        OneSignal.promptForPushNotifications(userResponse: { accepted in
            print("User accepted notifications: \(accepted)")
        })
        
        AppsFlyerLib.shared().appsFlyerDevKey = settingAnalyst.appsFlyerDevKey
        AppsFlyerLib.shared().appleAppID = settingAnalyst.appleAppID
        AppsFlyerLib.shared().delegate = self
        AppsFlyerLib.shared().isDebug = false
        if #available(iOS 10, *) {
            UNUserNotificationCenter.current().requestAuthorization(options: [.badge, .alert, .sound]) { _, _ in }
            application.registerForRemoteNotifications()
        } else {
            UIApplication.shared.registerUserNotificationSettings(UIUserNotificationSettings(types: [.badge, .sound, .alert], categories: nil))
            UIApplication.shared.registerForRemoteNotifications()
        }
        
        checkInstallWB() // Проверка установлено ли приложение на телефоне
        
        return true
    }
    
    private func checkInstallWB() {
        let appScheme = "wildberries://"
        let appUrl = URL(string: appScheme)

        if UIApplication.shared.canOpenURL(appUrl! as URL){
            //Приложение установлено
            AppsFlyerLib.shared().logEvent("af_wb_app_installed", withValues: ["af_wb_app_installed" : 1])
            //UIApplication.shared.open(appUrl!)
        } else {
            //Приложения нет
        }
    }
    
    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {}
}

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
