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
    let percent, price, sale: Int
    let description, equipment, specification: String
    let comments: Comments
    let urlWildberies: String

    enum CodingKeys: String, CodingKey {
        case id, name, images, percent, price, sale, description
        case equipment
        case specification = "specification "
        case comments
        case urlWildberies = "url_wildberies"
    }
}

// MARK: - Comments
struct Comments: Codable {
    let name, city: String
    let rating: Int
    let body: String
    let image: String
}
