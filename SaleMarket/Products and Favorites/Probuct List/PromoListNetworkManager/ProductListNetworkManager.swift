//
//  PromoListNetworkManager.swift
//  SaleMarket
//
//  Created by Timur Isaev on 27.11.2020.
//

import Foundation

class ProductListNetworkManager {
    
    static let urlFeatchProductList: String = "https://wtapp.ru/api/application/product-list/"
    
    private init() {}
    
    static func getProductList(completion: @escaping([ProductListModel]?) -> ()) {
        guard let url = URL(string: urlFeatchProductList) else { return }
        
        NetworkManager.shared.getData(metod: .get, url: url, parameters: nil) { (data, error) in
            if error != nil {
                completion(nil)
            }
            
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                let dataModel = try decoder.decode([ProductListModel].self, from: data)
                completion(dataModel)
            } catch {
                print(error)
                completion(nil)
            }
        }
    }
}