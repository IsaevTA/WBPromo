//
//  PromoListModel.swift
//  WBPromo
//
//  Created by Timur Isaev on 27.11.2020.
//

import Foundation

struct PromoListModel: Decodable {
    let id: Int
    let name: String
    let image: String
    let percent: Int
    let price: Int
    let sale: Int
}
