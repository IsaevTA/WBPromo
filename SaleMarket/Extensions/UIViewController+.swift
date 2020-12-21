//
//  UIViewController+.swift
//  SaleMarket
//
//  Created by UserDev on 17.12.2020.
//

import UIKit

extension UIViewController {

    func showAlert(withTitle title: String, withMessage message: String, preferredStyle: UIAlertController.Style, titleAction1: String, titleAction2: String, completion: @escaping () -> Void) {
        
        let searchFavorite = CoreDataManager.shared.searchFovorite(withName: message)
        
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "", message: "", preferredStyle: preferredStyle)

            let titleFont = [NSAttributedString.Key.font: UIFont(name: "ArialHebrew-Bold", size: 16.0)!]
            let messageFont = [NSAttributedString.Key.font: UIFont(name: "Avenir-Roman", size: 20.0)!]
            
            let titleAttrString = NSMutableAttributedString(string: title, attributes: titleFont)
            let messageAttrString = NSMutableAttributedString(string: message, attributes: messageFont)

            alert.setValue(titleAttrString, forKey: "attributedTitle")
            alert.setValue(messageAttrString, forKey: "attributedMessage")
            
            if titleAction1 != "" {
                let alertActionAddFavorite = UIAlertAction(title: titleAction1, style: .default) { action in
                    completion()
                }
                if searchFavorite {
                    alertActionAddFavorite.isEnabled = false
                } else {
                    alertActionAddFavorite.isEnabled = true
                }
                alert.addAction(alertActionAddFavorite)
            }
            
            let alertAction = UIAlertAction(title: titleAction2, style: .cancel, handler: nil)
            alert.addAction(alertAction)
            
            if let popover = alert.popoverPresentationController {
                popover.sourceView = self.navigationController?.navigationBar
            }
            
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func showAlert(withTitle title: String, withMessage message: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler:  nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
}
