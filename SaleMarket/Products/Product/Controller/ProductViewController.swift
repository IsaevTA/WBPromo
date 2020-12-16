//
//  DetailViewController.swift
//  WBPromo
//
//  Created by Timur Isaev on 04.12.2020.
//

import UIKit
import AppsFlyerLib
import NVActivityIndicatorView

class ProductViewController: UIViewController {
    
    var idProduct: Int?
    var currentPromo: ProductModel?
    
    var activityIndicatorView: NVActivityIndicatorView! = nil
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var titleNameLabel: UILabel!
    @IBOutlet weak var titleSaleLabel: UILabel!
    @IBOutlet weak var heightCustomBarConstraint: NSLayoutConstraint!
    @IBOutlet var swipeRight: UISwipeGestureRecognizer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let viewCenter = self.view.center
        let frame = CGRect(x: viewCenter.x - 50, y: viewCenter.y - 50, width: 100, height: 100)
        activityIndicatorView = NVActivityIndicatorView(frame: frame, type: .ballPulse, color: UIColor(red: 0.491, green: 0, blue: 0.722, alpha: 1))
        self.view.addSubview(activityIndicatorView)
        activityIndicatorView.startAnimating()
        
        NotificationCenter.default.addObserver(self, selector: #selector(backController), name: NSNotification.Name(rawValue: "BackProductList"), object: nil)
        
        featchData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tabBarController?.tabBar.isHidden = true
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    private func featchData() {
        guard let promo = idProduct else { return }
        
        ProductNetworkManager.getInfoProduct(withID: promo) { (infoPromo) in
            DispatchQueue.main.async {
                self.currentPromo = infoPromo
                self.updateUI(infoPromo: infoPromo)
                
                self.activityIndicatorView.stopAnimating()

                NotificationCenter.default.post(name: NSNotification.Name("FeatchPromo"), object: nil, userInfo: ["promo": infoPromo])
            }
        }
    }
    
    private func updateUI(infoPromo item: ProductModel) {
        titleNameLabel.text = item.name
        titleSaleLabel.text = "\(getFormattMoney(withNUmber: item.sale))"
    }
    
    @objc private func backController() {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func actionBackButton(_ sender: UIButton) {
        backController()
    }
    
    @IBAction func inStoreButton(_ sender: UIButton) {
        
        if let appScheme = currentPromo?.urlWildberies {
            let appUrl = URL(string: appScheme)
            
            if UIApplication.shared.canOpenURL(appUrl! as URL){
                //Открываем сылку или в приложении или в safari
                AppsFlyerLib.shared().logEvent("af_wb_button_pressed", withValues: ["af_wb_button_pressed" : 1])
                UIApplication.shared.open(appUrl!)
            }
        }
    }
    
    private func getFormattMoney(withNUmber number: Float) -> String {
        return "\(number) руб."
    }

}
