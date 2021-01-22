//
//  PromoListModel.swift
//  SaleMarket
//
//  Created by Timur Isaev on 27.11.2020.
//

import Foundation
import UIKit

struct ProductListModel: Codable {
    
    let id: Int
    let name: String
    let urlImage: String
    let image: Data?
    let percent: Int
    let price, sale: Float
    let externalLink: String
    let rating: Int
    let history: [WBPriceHistory]?
    let galleryString: [String]?
//    var galleryData: [Data]?
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case urlImage = "image"
        case image = "image_data"
        case percent, price, sale
        case externalLink = "external_link"
        case rating, history
        case galleryString = "gallery"
//        case galleryData
//        case itemCoreData = "item_coredata"
    }
    
    init(wihtWBProductListItem item: WBProductModel) {
        self.id = item.article
        self.name = item.name
        self.urlImage = item.image
        self.image = nil
        self.percent = Int(item.oldPrice != 0.0 ? 100.0 - (item.price * 100.0 / item.oldPrice) : 0.0)
        self.price = Float(item.oldPrice)
        self.sale = Float(item.price)
        self.rating = item.rating
        self.externalLink = item.url
        self.history = item.history
        self.galleryString = item.gallery
//        self.galleryData = nil
        
    }
    
    init(wihtProductListItem item: ProductList) {
        self.id = Int(item.id)
        self.name = item.name!
        self.urlImage = item.urlImage!
        self.image = item.image
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
        if let arrayImage = item.imageList {
//            self.galleryData = arrayImage.map({ ($0 as! ImageProduct).image  ?? Data() })
            self.galleryString = arrayImage.map({ ($0 as! ImageProduct).urlImage! })
        } else {
//            self.galleryData = nil
            self.galleryString = [String]()
        }
    }
}
