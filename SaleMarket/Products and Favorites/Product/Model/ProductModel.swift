//
//  ModelInfoPromo.swift
//  SaleMarket
//
//  Created by Timur Isaev on 01.12.2020.
//

import Foundation

// MARK: - InfoPromoModel
struct ProductModel: Codable {
    let id: Int
    let name: String
    let images: [String]
    let percent: Int
    let price, sale: Float
    let available: Bool
    let description: String
    let equipment, specification: [NameValueType]
    let comments: [Comments]
    let urlWildberies: String
    let rating: Float
    
    enum CodingKeys: String, CodingKey {
        case id, name, images, percent, price, sale, available, description, equipment, specification, comments
        case urlWildberies = "link"
        case rating
    }
    
    init(wihtWBProductListItem item: WBProductModel) {
        self.id = 1
        self.name = item.name
        self.images = item.gallery
        self.percent = Int(item.oldPrice != 0.0 ? 100.0 - (item.price * 100.0 / item.oldPrice) : 0.0)
        self.price = Float(item.oldPrice)
        self.sale = Float(item.price)
        self.rating = Float(item.rating)
        self.urlWildberies = item.url
        
        self.available = true
        self.description = ""
        self.equipment = [NameValueType]()
        self.specification = [NameValueType]()
        self.comments = [Comments]()
        
    }
}

// MARK: - Comments
struct Comments: Codable {
    let name, city: String
    let rating: Int
    let userAvatar: String
    let body: String
    let image: String

    enum CodingKeys: String, CodingKey {
        case name, city, rating
        case userAvatar = "user_avatar"
        case body, image
    }
}

// MARK: - Equipment
struct NameValueType: Codable {
    let name, value: String
}

