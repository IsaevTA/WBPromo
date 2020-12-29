//
//  ProductWebViewController.swift
//  SaleMarket
//
//  Created by Timur Isaev on 29.12.2020.
//

import UIKit
import WebKit
import NVActivityIndicatorView

class ProductWebViewController: UIViewController {
    
    @IBOutlet weak var webView: WKWebView!
    
    var activityIndicator: NVActivityIndicatorView!
    var urlString: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        webView.navigationDelegate = self
        
        activityIndicator = createActivitiIndicator(view: self.view, viewCenter: self.view.center, widhtHeight: 100, typeActivity: .ballRotateChase, color: UIColor(red: 0.491, green: 0, blue: 0.722, alpha: 1))
        activityIndicator.startAnimating()
        
        let request = URLRequest.init(url: URL(string: urlString)!)
        webView.load(request)
    }
    
    @IBAction func actionBackButton(_ sender: UIButton) {
        self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
        //navigationController?.popViewController(animated: true)
    }
}

extension ProductWebViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        activityIndicator.stopAnimating()
    }
}
