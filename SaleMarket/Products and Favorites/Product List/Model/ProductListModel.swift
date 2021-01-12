//
//  PromoListModel.swift
//  SaleMarket
//
//  Created by Timur Isaev on 27.11.2020.
//

import Foundation

struct ProductListModel: Decodable {
    let id: Int
    let name, image: String
    let percent: Int
    let price, sale: Float
    let rating: Int
    
    let url: String?
    
    init(wihtProductListItem item: Favorite) {
        self.id = Int(item.id)
        self.name = item.name!
        self.image = item.image!
        self.percent = Int(item.percent) 
        self.price = item.price
        self.sale = item.sale
        self.rating = 5
        self.url = ""
    }
    
    init(wihtWBProductListItem item: WBProductModel) {
        self.id = item.article
        self.name = item.name
        self.image = item.image
        self.percent = item.oldPrice != 0 ? 100 - (item.price * 100 / item.oldPrice) : 0
        self.price = Float(item.oldPrice)
        self.sale = Float(item.price)
        self.rating = item.rating
        self.url = item.url
    }
}
