//
//  NetworkManager.swift
//  SaleMarket
//
//  Created by Timur Isaev on 27.11.2020.
//

import Foundation

enum MetodRequest: String {
    case get = "GET"
    case post = "POST"
}

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
        
    //Создание HTTP POST запроса
    func createPOSTRequest(metod: MetodRequest, url: URL, parameters: [String: Any]?) -> URLRequest {
        var request = URLRequest(url: url, timeoutInterval: Double.infinity)
        request.httpMethod = metod.rawValue
        
        if let parametersTemp = parameters {
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: parametersTemp, options: .prettyPrinted)
            } catch {
                print(error.localizedDescription)
            }
        }
        
        //HTTP Headers
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")

        return request
    }
    
    func getData(metod: MetodRequest, url: URL, parameters: [String: Any]?, completionHandler: @escaping (Data?, Error?) -> ()) {
        
        DispatchQueue.global(qos: .userInteractive).async {
            let session = URLSession.shared
            let request = self.createPOSTRequest(metod: metod, url: url, parameters: parameters)

            session.dataTask(with: request) { (data, response, error) in
                if let error = error {
                    completionHandler(nil, error)
                }
                guard let data = data else { return }
                completionHandler(data, nil)
            }.resume()
        }
    }
}
