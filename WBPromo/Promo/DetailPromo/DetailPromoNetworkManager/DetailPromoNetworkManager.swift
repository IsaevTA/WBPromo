//
//  DetailPromoNetworkManager.swift
//  WBPromo
//
//  Created by Timur Isaev on 27.11.2020.
//

import Foundation

class DetailPromoNetworkManager {
    
    static let urlFeatchInfoPromo: String = "https://veradewa.site/ios/id/"
    
    private init() {}
    
    static func getInfoPromo(completion: @escaping(InfoPromoModel) -> ()) {
        guard let url = URL(string: urlFeatchInfoPromo) else { return }
        
        NetworkManager.shared.getData(metod: .post, url: url, parameters: [["id": 1]]) { (data) in
            do {
                let decoder = JSONDecoder()
                let dataModel = try decoder.decode([InfoPromoModel].self, from: data)
                completion(dataModel)
            } catch {
                print(error)
            }
        }
    }
}
