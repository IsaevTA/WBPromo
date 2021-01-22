//
//  UIView+.swift
//  SaleMarket
//
//  Created by Timur Isaev on 21.12.2020.
//

import UIKit

extension UIView {
    func removeAllSubView() {
        let _ = self.subviews.map { $0.removeFromSuperview() }
    }
}
