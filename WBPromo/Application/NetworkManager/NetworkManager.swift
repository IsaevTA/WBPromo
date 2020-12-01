//
//  NetworkService.swift
//  MVC-N
//
//  Created by Ivan Akulov on 19/01/2018.
//  Copyright © 2018 Ivan Akulov. All rights reserved.
//

import Foundation

enum MetodRequest: String {
    case get = "GET"
    case post = "POST"
}
class NetworkManager {
    
    private init() {}
    
    static let shared = NetworkManager()
    
    //Создание HTTP POST запроса
    func createPOSTRequest(metod: MetodRequest, url: URL, parameters: [[String: Any]]?) -> URLRequest {
    
        print("URL: \(url)")

        var request = URLRequest(url: url, timeoutInterval: Double.infinity)
        request.httpMethod = metod.rawValue
        
        if let parameters = parameters {
            print(parameters)
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
            } catch {
                print(error.localizedDescription)
            }
        }
        
        //HTTP Headers
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")

        return request
    }
    
    func getData(metod: MetodRequest, url: URL, parameters: [[String: Any]]?, completionHandler: @escaping (Data) -> ()) {
        
        DispatchQueue.global(qos: .userInteractive).async
        {
            let session = URLSession.shared
            let request = self.createPOSTRequest(metod: metod, url: url, parameters: parameters)
            
            session.dataTask(with: request) { (data, response, error) in
                guard let data = data else { return }
//                print(String(data: data, encoding: .utf8)!)
                completionHandler(data)
                
            }.resume()
        }
    }
}
