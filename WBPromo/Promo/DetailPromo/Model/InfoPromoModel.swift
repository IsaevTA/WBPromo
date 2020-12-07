//
//  ModelInfoPromo.swift
//  WBPromo
//
//  Created by Timur Isaev on 01.12.2020.
//

import Foundation

// MARK: - InfoPromoModel
struct InfoPromoModel: Codable {
    let id: Int
    let name: String
    let images: [String]
    let percent: Int
    let price, sale: Float
    let description, equipment, specification: String
    let comments: [Comments]
    let urlWildberies: String
    let rating: Int
    
    enum CodingKeys: String, CodingKey {
        case id, name, images, percent, price, sale, description, equipment, specification, comments
        case urlWildberies = "url_wildberies"
        case rating
    }
}

// MARK: - Comments
struct Comments: Codable {
    let name, city: String
    let rating: Int
    let user_avatar, body: String
    let image: String
}
