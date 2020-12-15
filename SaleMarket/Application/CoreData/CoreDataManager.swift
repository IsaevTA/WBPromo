//
//  CoreDat.swift
//  WBPromo
//
//  Created by Timur Isaev on 27.11.2020.
//

import Foundation
import CoreData

class CoreDataManager {
    
    static var shared = CoreDataManager()
    var context: NSManagedObjectContext!
    
    // MARK: - Core Data Favorites
    func saveFavorite(withProductListItem item: ProductListModel) {
        
        guard let entity = NSEntityDescription.entity(forEntityName: "Favorite", in: context) else { return }
        
        let newItem = Favorite(entity: entity, insertInto: context)
        newItem.id = Int32(item.id)
        newItem.image = item.image
        newItem.name = item.name
        newItem.percent = Int32(item.percent)
        newItem.price = item.price
        newItem.sale = item.sale
        
        do {
            try context.save()
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    func loadFavoritesFromCoreData(sortedStatus: Bool) -> [ProductListModel] {
        let fetchRequest: NSFetchRequest<Favorite> = Favorite.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: sortedStatus)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        do {
            let results = try context.fetch(fetchRequest)
            if results.isEmpty {
//                print("Данных в таблице нет")
            } else {
//                var arrayItems = [ProtuctListModel]()
//                for item in results {
//                    arrayItems.append(ProtuctListModel(wihtProductListItem: item))
//                }
                let arrayItems = results.map({ProductListModel(wihtProductListItem: $0)})
                return arrayItems
            }
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        
        return [ProductListModel]()
    }
    
    func searchFovorite(withName name: String) -> Bool {
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Favorite")

        fetchRequest.predicate = NSPredicate(format: "name = %@", name)

        do{
            let results = try context.fetch(fetchRequest)
            if results.isEmpty {
                return false
            } else {
                return true
            }
        } catch {
            return false
        }
    }
    
    func deleteFavoritesAll() {
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Favorite")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)

        do {
            try context.execute(deleteRequest)
            try context.save()
        } catch {
            print ("There was an error")
        }
    }
}
