//
//  DetailPromoNetworkManager.swift
//  WBPromo
//
//  Created by Timur Isaev on 27.11.2020.
//

import Foundation

class DetailPromoNetworkManager {
    
    static let urlFeatchInfoPromo: String = "https://eigannen.website/api/application/product/"
    
    private init() {}
    
    static func getInfoPromo(withID id: Int, completion: @escaping(InfoPromoModel) -> ()) {
        
        guard let url = URL(string: "\(urlFeatchInfoPromo)\(id)") else { return }
        
        NetworkManager.shared.getData(metod: .get, url: url, parameters: nil) { (data) in
            do {
                let decoder = JSONDecoder()
                let dataModel = try decoder.decode(InfoPromoModel.self, from: data)
                completion(dataModel)
            } catch {
                print(error)
            }
        }
    }
}
