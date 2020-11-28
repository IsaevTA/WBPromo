//
//  PromoListModel.swift
//  WBPromo
//
//  Created by Timur Isaev on 27.11.2020.
//

import Foundation

struct PromoListModel: Decodable {
    var id: Int
    var category: String
    var name: String
    var image: String
    var controct_time: Int
    var price: Int
    var sale: Int
    
//    init?(dict: [String: AnyObject]) {
//        guard let id = dict["id"] as? Int,
//              let category = dict["category"] as? String,
//              let name = dict["name"] as? String,
//              let image = dict["image"] as? String,
//              let controct_time = dict["controct_time"] as? String,
//              let price = dict["price"] as? Float,
//              let sale = dict["sale"] as? Float else { return nil }
//        
//        self.id = id
//        self.category = category
//        self.name = name
//        self.image = image
//        self.controct_time = controct_time
//        self.price = price
//        self.sale = sale
//    }
}
