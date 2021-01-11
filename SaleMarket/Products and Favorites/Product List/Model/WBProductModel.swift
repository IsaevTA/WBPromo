//
//  WBProductModel.swift
//  SaleMarket
//
//  Created by Timur Isaev on 09.01.2021.
//

import Foundation

// MARK: - WBProductModel
struct WBProductModel: Codable {
    let url: String
    let name: String
    let price: Int
    let availableProduct: String
    let oldPrice, rating, countReviews: Int
    let article, description: String
    let properties, searchWithProduct: [String]
    let image: String
    let gallery: [String]

    enum CodingKeys: String, CodingKey {
        case url, name, price
        case availableProduct = "available_product"
        case oldPrice = "old_price"
        case rating
        case countReviews = "count_reviews"
        case article, description, properties
        case searchWithProduct = "search_with_product"
        case image, gallery
    }
}
