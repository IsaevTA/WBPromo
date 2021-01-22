//
//  UIViewController+.swift
//  SaleMarket
//
//  Created by Timur Isaev on 17.12.2020.
//

import UIKit

extension UIViewController {
    func showAlert(withTitle title: String, withMessage message: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler:  nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
}
