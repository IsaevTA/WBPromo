//
//  PromoListNetworkManager.swift
//  SaleMarket
//
//  Created by Timur Isaev on 27.11.2020.
//

import Foundation

class ProductListNetworkManager {
    
    static let urlFeatchProductList: String = "https://wtapp.ru/api/application/product-list/"
    static let urlFeatchWBProductList: String = "https://veradewa.site/get_wb/"
    
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
    
    static func featchWBProductList(withURL wbURL: [String], completion: @escaping([ProductListModel]?) -> ()) {
        guard let url = URL(string: urlFeatchWBProductList) else { return }

//        let urlWBListData = CoreDataManager.shared.loadWbProductFromCoreData()
//
//        if urlWBListData.count == 0 {
//            completion([ProductListModel]())
//            return
//        }

//        let array = urlWBListData.map({String($0.wbUrlString!)})
        NetworkManager.shared.getData(metod: .post, url: url, parameters: ["product_link": wbURL]) { (data, error) in
            if error != nil {
                completion(nil)
            }

            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                let dataModel = try decoder.decode([WBProductModel].self, from: data)
                let dataParser = dataModel.map({ProductListModel(wihtWBProductListItem: $0)})
                completion(dataParser)
            } catch {
                print(error)
                completion(nil)
            }
        }
    }
    
    static func featchWBProductList(withURL wbURL: String, completion: @escaping(ProductListModel?) -> ()) {
        guard let url = URL(string: urlFeatchWBProductList) else { return }

        var array: [String] = []
        array.append(wbURL)
        
        NetworkManager.shared.getData(metod: .post, url: url, parameters: ["product_link": array]) { (data, error) in
            if error != nil {
                completion(nil)
            }
            
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                let dataModel = try decoder.decode([WBProductModel].self, from: data)
                let dataParser = dataModel.map({ProductListModel(wihtWBProductListItem: $0)})
                completion(dataParser.first)
            } catch {
                print(error)
                completion(nil)
            }
        }
    }
}
