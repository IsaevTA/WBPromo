//
//  WBProductModel.swift
//  SaleMarket
//
//  Created by Timur Isaev on 09.01.2021.
//

import Foundation

// MARK: - WBProductModel
struct WBProductModel: Codable {
    let history: [WBPriceHistory]
    let url: String
    let name: String
    let price: Float
    let availableProduct: String
    let oldPrice: Float
    let rating, countReviews, article: Int
    let description: String
    let properties, searchWithProduct: [String]?
    let image: String
    let gallery: [String]
    
    enum CodingKeys: String, CodingKey {
        case history, url, name, price
        case availableProduct = "available_product"
        case oldPrice = "old_price"
        case rating
        case countReviews = "count_reviews"
        case article, description, properties
        case searchWithProduct = "search_with_product"
        case image, gallery
    }
}

// MARK: - History
struct WBPriceHistory: Codable {
    let name: String
    let value: Float
    
    init(withItem item: HistoryPrice) {
        self.name = item.name!
        self.value = item.value
    }
}
