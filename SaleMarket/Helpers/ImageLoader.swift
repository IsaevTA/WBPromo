//
//  ImageLoader.swift
//  SaleMarket
//
//  Created by Timur Isaev on 07.12.2020.
//

import UIKit

class ImageLoader {
    var session: URLSession!
    var cache: NSCache<NSString, UIImage>!
    
    init() {
        session = URLSession.shared
        self.cache = NSCache()
    }
    
    func obtainImageWithPath(imagePath: String, completionHandler: @escaping (UIImage) -> ()) {
        if let image = self.cache.object(forKey: imagePath as NSString) {
            DispatchQueue.main.async {
                completionHandler(image)
            }
        } else {
//            let placeholder = #imageLiteral(resourceName: "basket")
//            DispatchQueue.main.async {
//                completionHandler(placeholder)
//            }
            let url: URL! = URL(string: imagePath)
            session.downloadTask(with: url, completionHandler: { (location, response, error) in
                if let data = try? Data(contentsOf: url) {
                    let img: UIImage! = UIImage(data: data)
                    self.cache.setObject(img, forKey: imagePath as NSString)
                    DispatchQueue.main.async {
                        completionHandler(img)
                    }
                }
            }).resume()
        }
    }
}
 
