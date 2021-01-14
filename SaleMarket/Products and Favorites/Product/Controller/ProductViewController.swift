//
//  DetailViewController.swift
//  SaleMarket
//
//  Created by Timur Isaev on 04.12.2020.
//

import UIKit
import AppsFlyerLib
import NVActivityIndicatorView

class ProductViewController: UIViewController {
    
    var idProduct: Int?
    var urlProduct: String?
    var currentProduct: ProductModel?
    var activityIndicator: NVActivityIndicatorView!
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var titleNameLabel: UILabel!
    @IBOutlet weak var titleSaleLabel: UILabel!
    @IBOutlet weak var heightCustomBarConstraint: NSLayoutConstraint!
    @IBOutlet weak var inStoreButton: UIButton!
    @IBOutlet weak var containerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        containerView.isHidden = true
        
        activityIndicator = createActivitiIndicator(view: self.view, viewCenter: self.view.center, widhtHeight: 100, typeActivity: .ballPulse, color: UIColor.white)
        activityIndicator.startAnimating()
        
        NotificationCenter.default.addObserver(self, selector: #selector(backController), name: NSNotification.Name(rawValue: "BackProductList"), object: nil)
        
        if let url = urlProduct {
            featchWBProductData(wihtURL: url)
        } else {
            featchData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tabBarController?.tabBar.isHidden = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    private func featchData() {
        guard let promo = idProduct else { return }
        
        ProductNetworkManager.featchInfoProduct(withID: promo) { (infoPromo) in
            guard let detailProduct = infoPromo else {
                NotificationCenter.default.post(name: NSNotification.Name("BackProductList"), object: nil)
                self.showAlert(withTitle: "Ошибка", withMessage: "Ошибка при получении данных. Повторите попытку позже.")
                self.activityIndicator.stopAnimating()
                self.containerView.isHidden = false
                
                return
            }
            DispatchQueue.main.async {
                self.currentProduct = detailProduct
                self.updateUI(infoPromo: detailProduct)
                
                self.activityIndicator.stopAnimating()

                self.containerView.isHidden = false
                
                NotificationCenter.default.post(name: NSNotification.Name("FeatchProduct"), object: nil, userInfo: ["product": detailProduct])
            }
        }
    }
    
    private func featchWBProductData(wihtURL url: String) {
        ProductNetworkManager.featchWBInfoProduct(withURL: url) { (infoPromo) in
            guard let detailProduct = infoPromo else {
                NotificationCenter.default.post(name: NSNotification.Name("BackProductList"), object: nil)
                self.showAlert(withTitle: "Ошибка", withMessage: "Ошибка при получении данных. Повторите попытку позже.")
                self.activityIndicator.stopAnimating()
                self.containerView.isHidden = false
                
                return
            }
            DispatchQueue.main.async {
                self.currentProduct = detailProduct
                self.updateUI(infoPromo: detailProduct)
                
                self.activityIndicator.stopAnimating()

                self.containerView.isHidden = false
                
                NotificationCenter.default.post(name: NSNotification.Name("FeatchProduct"), object: nil, userInfo: ["product": detailProduct])
            }
        }
    }
    
    private func updateUI(infoPromo item: ProductModel) {
    
//        if currentProduct?.available == true {
//            inStoreButton.setImage(UIImage.returnImageBasket(), for: .normal)
//            inStoreButton.setTitle("  В МАГАЗИН", for: .normal)
//        } else {
//            inStoreButton.setImage(nil, for: .normal)
//            inStoreButton.setTitle("  В ОЖИДАНИЕ", for: .normal)
//        }
        
        inStoreButton.setImage(nil, for: .normal)
        inStoreButton.setTitle("ОТКРЫТЬ НА WILDBERRIES", for: .normal)
        
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
        
//        if currentProduct?.available == true {
            if let appScheme = currentProduct?.urlWildberies {
                let appUrl = URL(string: appScheme)

                //Открытие в приложении
                if UIApplication.shared.canOpenURL(appUrl! as URL) {
                    //Открываем сылку или в приложении или в safari
                    AppsFlyerLib.shared().logEvent("af_wb_button_pressed", withValues: ["af_wb_button_pressed" : 1])
                    UIApplication.shared.open(appUrl!)
                }
            }
//        } else {
//            self.showAlert(withTitle: "", withMessage: "Добавить \(String(describing: currentProduct?.name)) в лист ожидания?", preferredStyle: .actionSheet, titleAction1: "Добавить", titleAction2: "Отмена") {
//                print("Нажата добавить")
//            }
//        }
    }
    
    private func getFormattMoney(withNUmber number: Float) -> String {
        return "\(number) руб."
    }

    // MARK: - Segues
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showProductWeb" {
            if let urlString = currentProduct?.urlWildberies {
                let webViewController = segue.destination as! ProductWebViewController
                webViewController.urlString = urlString
            }
        }
    }
}
