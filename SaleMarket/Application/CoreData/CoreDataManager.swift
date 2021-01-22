//
//  CoreDataManager.swift
//  SaleMarket
//
//  Created by Timur Isaev on 27.11.2020.
//

import Foundation
import CoreData

class CoreDataManager {
    static var shared = CoreDataManager()
    var context: NSManagedObjectContext!
    
    func featchAndSaveImageProductList(withUrlString urlString: String, coreDataItem item: ProductList) {
        URLSession.shared.dataTask(with: NSURL(string: urlString)! as URL, completionHandler: { (data, response, error) -> Void in
            if error == nil {
                DispatchQueue.main.async { [self] in
                    if let imageData = data {
                        item.image = imageData
                        do {
                            try context.save()
                        } catch let error as NSError {
                            print(error.localizedDescription)
                        }
                    }
                }
            }
        }).resume()
    }
    
    func featchAndSaveImageInList(withUrlString urlString: String, coreDataItem item: ImageProduct) {
        URLSession.shared.dataTask(with: NSURL(string: urlString)! as URL, completionHandler: { (data, response, error) -> Void in
            if error == nil {
                DispatchQueue.main.async { [self] in
                    if let imageData = data {
                        item.image = imageData
                        do {
                            try context.save()
                        } catch let error as NSError {
                            print(error.localizedDescription)
                        }
                    }
                }
            }
        }).resume()
    }
}

