//
//  NetworkService.swift
//  MVC-N
//
//  Created by Ivan Akulov on 19/01/2018.
//  Copyright © 2018 Ivan Akulov. All rights reserved.
//

import Foundation

class NetworkManager {
    
    private init() {}
    
    static let shared = NetworkManager()
    
    func getData(url: URL, completionHandler: @escaping (Data) -> ()) {
        let session = URLSession.shared
        
        session.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            
            do {
//                let json = try JSONSerialization.jsonObject(with: data, options: [])
//                print(json)
                
                completionHandler(data)
            } catch {
                print(error)
            }
        }.resume()
    }
}
