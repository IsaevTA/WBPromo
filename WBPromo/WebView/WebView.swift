//
//  WebView.swift
//  WBPromo
//
//  Created by Timur Isaev on 30.11.2020.
//

import UIKit
import WebKit

class WebView: NSObject {
    static let shared = WebView()
    
    private var bridge: WKWebViewJavascriptBridge!
    
    func showWebView(withURL url: String?, andView view: UIView) {
        
        let userContentController = WKUserContentController()
        
        let webConfiguration = WKWebViewConfiguration()

        if let scriptPath = Bundle.main.path(forResource: "main_start", ofType: "js") {
            do {
                let scriptString = try String(contentsOfFile: scriptPath, encoding: .utf8)
                let script = WKUserScript(source: scriptString, injectionTime: .atDocumentStart, forMainFrameOnly: false)
                userContentController.addUserScript(script)
            } catch let error { print("webView loadDemoPage error: \(error)") }
            webConfiguration.userContentController = userContentController
        }
        
        if let scriptPath = Bundle.main.path(forResource: "main_finish", ofType: "js") {
            do {
                let scriptString = try String(contentsOfFile: scriptPath, encoding: .utf8)
                let script = WKUserScript(source: scriptString, injectionTime: .atDocumentEnd, forMainFrameOnly: false)
                userContentController.addUserScript(script)
            } catch let error { print("webView loadDemoPage error: \(error)") }
            webConfiguration.userContentController = userContentController
        }
        
        let webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.backgroundColor = UIColor(red:0.16, green:0.15, blue:0.34, alpha:1.0)
        webView.frame = view.bounds
        view.addSubview(webView)

        webView.translatesAutoresizingMaskIntoConstraints = false
        if #available(iOS 11, *) {
            let guide: UILayoutGuide = view.safeAreaLayoutGuide
            webView.leadingAnchor.constraint(equalTo: guide.leadingAnchor).isActive = true
            webView.trailingAnchor.constraint(equalTo: guide.trailingAnchor).isActive = true
            webView.topAnchor.constraint(equalTo: guide.topAnchor).isActive = true
            webView.bottomAnchor.constraint(equalTo: guide.bottomAnchor).isActive = true
        } else {
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
            webView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        }

        webView.scrollView.decelerationRate = UIScrollView.DecelerationRate.normal
        webView.scrollView.bounces = false
        webView.scrollView.delegate = self
        webView.uiDelegate = self
        webView.navigationDelegate = self
        webView.allowsLinkPreview = false

        // setup bridge
        bridge = WKWebViewJavascriptBridge(webView: webView)
        bridge.isLogEnable = false
        bridge.register(handlerName: "getItem") { (paramters, callback) in
            guard let nameItem = paramters!["nameItem"] as? String else { return }
            
            let currentValue = UserDefaults.standard.string(forKey: nameItem)
//            print("GetItem: \(nameItem) - \(currentValue)")
            callback?((currentValue != nil) ? currentValue : "")
        }
        
        bridge.register(handlerName: "setItem") { (paramters, callback) in
            guard let nameItem = paramters!["nameItem"] as? String,
                  let valueItem = paramters!["valueItem"] as? String else { return }
            
//            print("SetItem: \(nameItem) - \(valueItem)")
            
            UserDefaults.standard.set(valueItem, forKey: nameItem)
            callback?("OK")
        }
        
        HTTPCookieStorage.shared.cookieAcceptPolicy = .always

        if let url = url {
            print("URL - \(url)")
            let request = URLRequest.init(url: URL(string: url)!)
            webView.load(request)
        }
    }
}

//MARK: - Отключаем скрол
extension WebView: UIScrollViewDelegate {
    func scrollViewWillBeginZooming(_ scrollView: UIScrollView, with view: UIView?) {
             scrollView.pinchGestureRecognizer?.isEnabled = false
    }
}

//MARK: - WKUIDelegate
extension WebView: WKUIDelegate {
    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        if let frame = navigationAction.targetFrame,
            frame.isMainFrame {
            return nil
        }
        webView.load(navigationAction.request)
        return nil
    }
}

//MARK: - WKNavigationDelegate
extension WebView: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {}
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {}
}
