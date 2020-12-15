//
//  SettingsApplication.swift
//  SaleMarket
//
//  Created by UserDev on 15.12.2020.
//

import Foundation

class FavoritesManager {
    static let shared = FavoritesManager()

    var favoritesProduct: [Int] {
        get { return UserDefaults.standard.array(forKey: "WB_PRODUCT_FAVORITES") as? [Int] ?? [Int]() }
        set(newCenter) { UserDefaults.standard.set(newCenter, forKey: "WB_PRODUCT_FAVORITES") }
    }
    
    func checkFovarite(withId id: Int) -> Bool {
        let favoriteArray = favoritesProduct
        if favoriteArray.first(where: { $0 == id }) != nil {
            return true
        }
        return false
    }
    
    func addFavorite(wihtId id: Int) {
        var favoriteArray = favoritesProduct
        favoriteArray.append(id)
        favoritesProduct = favoriteArray
    }
    
    func deleteFavorite(wihtId id: Int) {
        var favoriteArray = favoritesProduct
        if checkFovarite(withId: id) == true {
            if let index = favoriteArray.firstIndex(of: id) {
                favoriteArray.remove(at: index)
                favoritesProduct = favoriteArray
            }
        }
    }
}
