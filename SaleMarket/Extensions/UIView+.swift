//
//  UIView+.swift
//  SaleMarket
//
//  Created by UserDev on 21.12.2020.
//

import UIKit

extension UIView {
    func removeAllSubView() {
        let _ = self.subviews.map { $0.removeFromSuperview() }
//        for item in self.subviews {
//            item.removeFromSuperview()
//        }
    }
}
