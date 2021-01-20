//
//  PromoListModel.swift
//  SaleMarket
//
//  Created by Timur Isaev on 27.11.2020.
//

import Foundation

struct ProductListModel: Codable {
    
    let id: Int
    let name: String
    let image: String
    let percent: Int
    let price, sale: Float
    let externalLink: String
    let rating: Int

    let history: [WBPriceHistory]?
    
    enum CodingKeys: String, CodingKey {
        case id, name, image, percent, price, sale
        case externalLink = "external_link"
        case rating, history
    }
//
//    let id: Int
//    let name, image: String
//    let percent: Int
//    let price, sale: Float
//    let rating: Int
//    let external_link: String
//    let url: String?
//    let history: [WBPriceHistory]?
    
//    init(wihtProductListItem item: Favorite) {
//        self.id = Int(item.id)
//        self.name = item.name!
//        self.image = item.image!
//        self.percent = Int(item.percent) 
//        self.price = item.price
//        self.sale = item.sale
//        self.rating = 5
//        self.externalLink = ""
//        self.history = nil
//    }
    
    init(wihtWBProductListItem item: WBProductModel) {
        self.id = item.article
        self.name = item.name
        self.image = item.image
        self.percent = Int(item.oldPrice != 0.0 ? 100.0 - (item.price * 100.0 / item.oldPrice) : 0.0)
        self.price = Float(item.oldPrice)
        self.sale = Float(item.price)
        self.rating = item.rating
        self.externalLink = item.url
        self.history = item.history
    }
    
    init(wihtProductListItem item: ProductList) {
        self.id = Int(item.id)
        self.name = item.name!
        self.image = item.image!
        self.percent = Int(item.price != 0.0 ? 100.0 - (item.sale * 100.0 / item.price) : 0.0)
        self.price = Float(item.price)
        self.sale = Float(item.sale)
        self.rating = Int(item.rating)
        self.externalLink = item.externalLink!
        if let arrayHistory = item.historyList {
            self.history = arrayHistory.map({ WBPriceHistory(withItem: $0 as! HistoryPrice) }).sorted(by: { $0.name < $1.name })
        } else {
            self.history =  nil
        }
    }
}
