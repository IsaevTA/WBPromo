//
//  ShareViewController.swift
//  ShareExtension
//
//  Created by Timur Isaev on 07.01.2021.
//

import UIKit
import Social
import MobileCoreServices

class ShareViewController: SLComposeServiceViewController {

//    private let typeText = String(kUTTypeText)
    private let typeURL = String(kUTTypeURL)
    
    private let appURL = "SaleMarket://"
    private let groupName = "group.SaleMarket"
//    private let wbProductName = "WB_PRODUCT_NAME"
    private let wbProductUrl = "WB_PRODUCT_URL"
    
//    override func didSelectPost() {
//        if let item = extensionContext?.inputItems.first as? NSExtensionItem {
//            if let itemProvider = item.attachments?.first {
//                if itemProvider.hasItemConformingToTypeIdentifier(typeURL) {
//                    itemProvider.loadItem(forTypeIdentifier: typeURL, options: nil, completionHandler: { (url, error) -> Void in
//                        if let shareURL = url as? NSURL {
//
//                            print(shareURL)
//                        }
//                        self.extensionContext?.completeRequest(returningItems: [], completionHandler:nil)
//                    })
//                }
//            }
//        }
//    }
    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        // 1
//        guard let extensionItem = extensionContext?.inputItems.first as? NSExtensionItem,
//            let itemProvider = extensionItem.attachments?.first else {
//                self.extensionContext?.completeRequest(returningItems: nil, completionHandler: nil)
//                return
//        }
//
//        if itemProvider.hasItemConformingToTypeIdentifier(typeText) {
//            handleIncomingText(itemProvider: itemProvider)
//        } else if itemProvider.hasItemConformingToTypeIdentifier(typeURL) {
//            handleIncomingURL(itemProvider: itemProvider)
//        } else {
//            print("Error: No url or text found")
//            self.extensionContext?.completeRequest(returningItems: nil, completionHandler: nil)
//        }
//    }
        
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
        guard let extensionItem = extensionContext?.inputItems.first as? NSExtensionItem,
              let _ = extensionItem.attachments?.first else {
                self.extensionContext?.completeRequest(returningItems: nil, completionHandler: nil)
                return
        }
        
        fetchAndSetContentFromContext()

//        if itemProvider.hasItemConformingToTypeIdentifier(typeText) {
//            handleIncomingText(itemProvider: itemProvider)
//        } else if itemProvider.hasItemConformingToTypeIdentifier(typeURL) {
//            handleIncomingURL(itemProvider: itemProvider)
//        } else {
//            print("Error: No url or text found")
//            self.extensionContext?.completeRequest(returningItems: nil, completionHandler: nil)
//        }
    }

//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        if let item = extensionContext?.inputItems.first as? NSExtensionItem {
//            if let itemProvider = item.attachments?.first {
//                if itemProvider.hasItemConformingToTypeIdentifier(typeURL) {
//                    itemProvider.loadItem(forTypeIdentifier: typeURL, options: nil, completionHandler: { (url, error) -> Void in
//                        if let shareURL = url as? NSURL {
//                            print("Получаем url - \(shareURL)")
//                        }
//                        self.extensionContext?.completeRequest(returningItems: [], completionHandler:nil)
//                    })
//                }
//            }
//        }
//    }
        
    private func fetchAndSetContentFromContext() {
        
        guard let extensionItems = extensionContext?.inputItems as? [NSExtensionItem] else { return }
        
        for extensionItem in extensionItems {
            if let itemProviders = extensionItem.attachments {
                for itemProvider in itemProviders {
                    if itemProvider.hasItemConformingToTypeIdentifier(typeURL) {
                        itemProvider.loadItem(forTypeIdentifier: typeURL, options: nil, completionHandler: { item, error in
                            if let error = error {
                                print("URL-Error: \(error.localizedDescription)")
                            }
                
                            if let url = item as? NSURL, let urlString = url.absoluteString {
                                self.saveURLString(urlString)
                            }
                
                            self.openMainApp()
                        })
                    }
                }
            }
        }
    }
    
//    private func handleIncomingText(itemProvider: NSItemProvider) {
//        itemProvider.loadItem(forTypeIdentifier: typeText, options: nil) { (item, error) in
//            if let error = error { print("Text-Error: \(error.localizedDescription)") }
//            if let text = item as? String {
//                do {// 2.1
//                    let detector = try NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
//                    let matches = detector.matches(in: text, options: [], range: NSRange(location: 0, length: text.utf16.count))
//                    // 2.2
//                    if let firstMatch = matches.first, let range = Range(firstMatch.range, in: text) {
//                        self.saveURLString(String(text[range]))
//                    }
//                } catch let error {
//                    print("Do-Try Error: \(error.localizedDescription)")
//                }
//            }
//
//            self.openMainApp()
//        }
//    }
//
//    private func handleIncomingURL(itemProvider: NSItemProvider) {
//        itemProvider.loadItem(forTypeIdentifier: self.typeURL, options: nil) { (item, error) in
//            if let error = error { print("URL-Error: \(error.localizedDescription)") }
//
//            if let url = item as? NSURL, let urlString = url.absoluteString {
//                self.saveURLString(urlString)
//            }
//
//            self.openMainApp()
//        }
//    }

    private func saveURLString(_ urlString: String) {
        UserDefaults(suiteName: self.groupName)?.set(urlString, forKey: self.wbProductUrl)
    }

//    private func saveNameString(_ urlString: String) {
//        UserDefaults(suiteName: self.groupName)?.set(urlString, forKey: self.wbProductName)
//    }
//
    private func openMainApp() {
        self.extensionContext?.completeRequest(returningItems: nil, completionHandler: { _ in
            guard let url = URL(string: self.appURL) else { return }
            _ = self.openURL(url)
        })
    }

    @objc private func openURL(_ url: URL) -> Bool {
        var responder: UIResponder? = self
        while responder != nil {
            if let application = responder as? UIApplication {
                return application.perform(#selector(openURL(_:)), with: url) != nil
            }
            responder = responder?.next
        }
        return false
    }

}
