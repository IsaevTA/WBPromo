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
    
//    func deleteFavoritesAll() {
//        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Favorite")
//        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
//
//        do {
//            try context.execute(deleteRequest)
//            try context.save()
//        } catch {
//            print ("There was an error")
//        }
//    }

}

