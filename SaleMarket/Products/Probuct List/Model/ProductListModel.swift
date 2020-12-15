//
//  PromoListModel.swift
//  WBPromo
//
//  Created by Timur Isaev on 27.11.2020.
//

import Foundation

struct ProductListModel: Decodable {
    let id: Int
    let name, image: String
    let percent: Int
    let price, sale: Float
    
    init(wihtProductListItem item: Favorite) {
        self.id = Int(item.id)
        self.name = item.name!
        self.image = item.image!
        self.percent = Int(item.percent)
        self.price = item.price
        self.sale = item.sale
    }
}
