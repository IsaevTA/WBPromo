//
//  WebViewController.swift
//  SaleMarket
//
//  Created by Timur Isaev on 24.12.2020.
//

import UIKit
import WebKit
import NVActivityIndicatorView

class WebViewController: UIViewController {

    @IBOutlet weak var viewWithWeb: UIView!
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    var currentNews: NewsModel?
    var activityIndicator: NVActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        webView.navigationDelegate = self
        webView.isHidden = true
        
        activityIndicator = createActivitiIndicator(view: self.view, viewCenter: self.view.center, widhtHeight: 100, typeActivity: .ballRotateChase, color: UIColor(red: 0.491, green: 0, blue: 0.722, alpha: 1))
        activityIndicator.startAnimating()
        
        //настройка свайпа назад
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
        swipeRight.direction = UISwipeGestureRecognizer.Direction.right
        self.view.addGestureRecognizer(swipeRight)
        
        titleLabel.text = currentNews?.name
        imageView.image = UIImage(named: currentNews!.image)
        
        if let urlString = currentNews?.urlNews {
            if urlString.isValidURL {
                let request = URLRequest.init(url: URL(string: urlString)!)
                webView.load(request)
            } else {
                let url = Bundle.main.url(forResource: urlString, withExtension: "html")!
                webView.loadFileURL(url, allowingReadAccessTo: url)
                let request = URLRequest(url: url)
                webView.load(request)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tabBarController?.tabBar.isHidden = true
    }
    
    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        backController()
    }
    
    @IBAction func actionBackButton(_ sender: UIButton) {
        backController()
    }
    
    private func backController() {
        navigationController?.popViewController(animated: true)
    }
}

extension WebViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        activityIndicator.stopAnimating()
        webView.isHidden = false
    }
}
