//
//  CoreDataManager+WBProduct.swift
//  SaleMarket
//
//  Created by UserDev on 20.01.2021.
//

import Foundation
import CoreData

// MARK: - Core Data WBProduct
extension CoreDataManager {
//    func saveWBProduct(withUrlProduct url: String) {
//        
//        guard let entity = NSEntityDescription.entity(forEntityName: "WBProductList", in: context) else { return }
//        
//        let newItem = WBProductList(entity: entity, insertInto: context)
//        newItem.wbUrlString = url
//        
//        do {
//            try context.save()
//        } catch let error as NSError {
//            print(error.localizedDescription)
//        }
//    }
//    
//    func loadWbProductFromCoreData() -> [WBProductList] {
//        let fetchRequest: NSFetchRequest<WBProductList> = WBProductList.fetchRequest()
//        
//        do {
//            let results = try context.fetch(fetchRequest)
//            if results.isEmpty {
//                print("Данных в таблице нет")
//            } else {
//                return results
//            }
//        } catch {
//            print(error.localizedDescription)
//        }
//        
//        return [WBProductList]()
//    }
//    
//    func deleteFromWBProductList(wihtURL url: String) {
//        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "WBProductList")
//        fetchRequest.predicate = NSPredicate(format: "wbUrlString = %@", url)
//
//        do {
//            let results = try context.fetch(fetchRequest)
//            if results.isEmpty {
//                
//            } else {
//                let _ = results.map({context.delete($0 as! NSManagedObject)})
//                try context.save()
//            }
//        } catch {
//            return
//        }
//    }
//    
//    func checkInListWBProduct(wihtURL url: String) -> Bool {
//        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "WBProductList")
//        fetchRequest.predicate = NSPredicate(format: "wbUrlString = %@", url)
//
//        do {
//            let results = try context.fetch(fetchRequest)
//            if results.isEmpty {
//                return false
//            } else {
//                return true
//            }
//        } catch {
//            return false
//        }
//    }
}
