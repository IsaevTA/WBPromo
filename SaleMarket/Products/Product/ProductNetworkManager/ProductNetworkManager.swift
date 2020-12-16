//
//  DetailPromoNetworkManager.swift
//  WBPromo
//
//  Created by Timur Isaev on 27.11.2020.
//

import Foundation

class ProductNetworkManager {
    
    static let urlFeatchInfoProduct: String = "https://eigannen.website/api/application/product/"
    
    private init() {}
    
    static func getInfoProduct(withID id: Int, completion: @escaping(ProductModel) -> ()) {
        
        guard let url = URL(string: "\(urlFeatchInfoProduct)\(id)") else { return }
        
        NetworkManager.shared.getData(metod: .get, url: url, parameters: nil) { (data) in
            do {
                let decoder = JSONDecoder()
                let dataModel = try decoder.decode(ProductModel.self, from: data)
                completion(dataModel)
            } catch {
                print(error)
            }
        }
    }
}
