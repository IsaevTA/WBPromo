//
//  DetailPromoNetworkManager.swift
//  SaleMarket
//
//  Created by Timur Isaev on 27.11.2020.
//

import Foundation

class ProductNetworkManager {
    
    static let urlFeatchInfoProduct: String = "https://eigannen.website/api/application/product/"
    static let urlFeatchWBProductList: String = "https://veradewa.site/get_wb/"
    
    private init() {}
    
    static func featchInfoProduct(withID id: Int, completion: @escaping(ProductModel?) -> ()) {
        
        guard let url = URL(string: "\(urlFeatchInfoProduct)\(id)") else { return }
        
        NetworkManager.shared.getData(metod: .get, url: url, parameters: nil) { (data, error) in
            if error != nil {
                completion(nil)
            }
            
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                let dataModel = try decoder.decode(ProductModel.self, from: data)
                completion(dataModel)
            } catch {
                print(error)
                completion(nil)
            }
        }
    }
    
    static func featchWBInfoProduct(withURL url: String, completion: @escaping(ProductModel?) -> ()) {
        guard let urlService = URL(string: urlFeatchWBProductList) else { return }
        
        NetworkManager.shared.getData(metod: .post, url: urlService, parameters: ["product_link": (url)]) { (data, error) in
            if error != nil {
                completion(nil)
            }
            
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                let dataModel = try decoder.decode([WBProductModel].self, from: data)
                let dataParser = ProductModel(wihtWBProductListItem: dataModel.first!)
                completion(dataParser)
            } catch {
                print(error)
                completion(nil)
            }
        }
    }
}
