//
//  PromoListNetworkManager.swift
//  WBPromo
//
//  Created by Timur Isaev on 27.11.2020.
//

import Foundation

class PromoListNetworkManager {
    
    static let urlFeatchPromoList: String = "https://wtapp.ru/api/application/product-list/"
    
    private init() {}
    
    static func getPromoList(completion: @escaping([PromoListModel]) -> ()) {
        guard let url = URL(string: urlFeatchPromoList) else { return }
        
        NetworkManager.shared.getData(metod: .get, url: url, parameters: nil) { (data) in
            do {
                let decoder = JSONDecoder()
                let dataModel = try decoder.decode([PromoListModel].self, from: data)
                completion(dataModel)
            } catch {
                print(error)
            }
        }
    }
}
