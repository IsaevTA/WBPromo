//
//  CommentNetworkService.swift
//  MVC-N
//
//  Created by Ivan Akulov on 21/10/2017.
//  Copyright © 2017 Ivan Akulov. All rights reserved.
//

import Foundation

class PromoListNetworkManager {
    private init() {}
    
    static func getPromoList(completion: @escaping([PromoListModel]) -> ()) {
        guard let url = URL(string: "https://veradewa.site/ios/") else { return }
        
        NetworkManager.shared.getData(url: url) { (data) in
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
