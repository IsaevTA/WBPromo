//
//  AppDelegate.swift
//  SaleMarket
//
//  Created by Timur Isaev on 27.11.2020.
//

import UIKit
import OneSignal
import AppsFlyerLib
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    let settingAnalyst = SettingsAnalist.shared
    var coreDataStack = CoreDataStack()
    
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
        
        if !settingAnalyst.wbInstalled { checkInstallWB() } // Проверка установлено ли приложение на телефоне
        if !settingAnalyst.firstStart { checkFirstStart() } // Проверка на первый запуск
        
        CoreDataManager.shared.context = (UIApplication.shared.delegate as? AppDelegate)?.coreDataStack.persistentContainer.viewContext
        
        return true
    }
    
    private func checkInstallWB() {
        let appScheme = "wildberries://"
        let appUrl = URL(string: appScheme)

        if UIApplication.shared.canOpenURL(appUrl! as URL){
            //Приложение установлено
            AppsFlyerLib.shared().logEvent("af_wb_app_installed", withValues: ["af_wb_app_installed" : 1])
            settingAnalyst.wbInstalled = true
        }
    }
    
    private func checkFirstStart() {
        AppsFlyerLib.shared().logEvent("af_install_app", withValues: ["af_install_app" : true])
        settingAnalyst.firstStart = true
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        AppsFlyerLib.shared().start()
    }

    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) {
        print(" user info \(userInfo)")
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
        if let scheme = url.scheme,
            scheme.caseInsensitiveCompare("SaleMarket") == .orderedSame,
            let page = url.host {

            var parameters: [String: String] = [:]
            URLComponents(url: url, resolvingAgainstBaseURL: false)?.queryItems?.forEach {
                parameters[$0.name] = $0.value
            }

            print("redirect(to: \(page), with: \(parameters))")

            for parameter in parameters where parameter.key.caseInsensitiveCompare("url") == .orderedSame {
                UserDefaults().set(parameter.value, forKey: "incomingURL")
            }
        }
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

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {}
    }

//MARK: AppsFlyerTrackerDelegate
extension AppDelegate: AppsFlyerLibDelegate{
    func onConversionDataSuccess(_ installData: [AnyHashable: Any]) {
        AnalyticsManager.shared.featchDeepLinkAppsFlyer(withData: installData)
    }
    
    func onConversionDataFail(_ error: Error) {
        print(error)
    }
    
    func onAppOpenAttribution(_ attributionData: [AnyHashable : Any]) {
        AnalyticsManager.shared.featchDeepLinkAppsFlyer(withData: attributionData)
    }
    
    func onAppOpenAttributionFailure(_ error: Error) {
        print(error)
    }
}
