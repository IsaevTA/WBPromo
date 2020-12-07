//
//  DetailViewController.swift
//  WBPromo
//
//  Created by Timur Isaev on 04.12.2020.
//

import UIKit
import AppsFlyerLib

class DetailViewController: UIViewController {
    
    var promoWithListPromo: PromoListModel?
    var currentPromo: InfoPromoModel?
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var titleNameLabel: UILabel!
    @IBOutlet weak var titleSaleLabel: UILabel!
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        featchData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    private func featchData() {
        guard let promo = promoWithListPromo else { return }
        
        DetailPromoNetworkManager.getInfoPromo(withID: promo.id) { (infoPromo) in
            DispatchQueue.main.async {
                self.currentPromo = infoPromo
                self.updateUI(infoPromo: infoPromo)
                
                NotificationCenter.default.post(name: NSNotification.Name("FeatchPromo"), object: nil, userInfo: ["promo": infoPromo])
            }
        }
    }
    
    private func updateUI(infoPromo item: InfoPromoModel) {
        titleNameLabel.text = item.name
        titleSaleLabel.text = "\(getFormattMoney(withNUmber: item.sale))"
    }
    
    @IBAction func actionBackButton(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
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