//
//  CustomNavigationBarDelegate.swift
//  SaleMarket
//
//  Created by UserDev on 22.12.2020.
//

import Foundation

@objc protocol CustomNavigationBarDelegate: class {
    @objc optional func searchNavigationBar(searchText: String)
    func backToHome()
}
