//
//  CoreDataManager+ProductList.swift
//  SaleMarket
//
//  Created by UserDev on 20.01.2021.
//

import Foundation
import UIKit
import CoreData

// MARK: - Core Data ProductList
extension CoreDataManager {
    func saveProductList(withProductItem item: ProductListModel, updateUI: Bool = false) {
        
        guard let entityProduct = NSEntityDescription.entity(forEntityName: "ProductList", in: context) else { return }
        guard let entityHistory = NSEntityDescription.entity(forEntityName: "HistoryPrice", in: context) else { return }
        
        let newItem = ProductList(entity: entityProduct, insertInto: context)
        newItem.id = Int64(item.id)
        newItem.name = item.name
        newItem.image = item.image
        newItem.externalLink = item.externalLink
        newItem.percent = Int16(item.percent)
        newItem.price = item.price
        newItem.rating = Int16(item.rating)
        newItem.sale = item.sale

        if let array = item.history {
            for currentItem in array {
                let newItemHistory = HistoryPrice(entity: entityHistory, insertInto: context)
                newItemHistory.name = currentItem.name
                newItemHistory.value = currentItem.value
                newItem.addToHistoryList(newItemHistory)
            }
        }

        do {
            try context.save()
            if item.history != nil {
                updadaItem(withItem: item, updataUI: updateUI)
            }
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        
    }
    
    func saveProductList(withUrlProduct url: String, updateUI: Bool = false) {
        
        let check = checkInProductList(wihtURL: url)
        if check { return }
        
        ProductListNetworkManager.featchWBProductList(withURL: url, completion: { (productArray) in
            guard let item = productArray else { return }

            DispatchQueue.main.async { [unowned self] in
        
                saveProductList(withProductItem: item)

                if updateUI {
                    NotificationCenter.default.post(name: NSNotification.Name("UpdateTableWB"), object: nil)
                }
            }
        })
    }
    
    func loadProductListFromCoreData() -> [ProductListModel] {
        let fetchRequest: NSFetchRequest<ProductList> = ProductList.fetchRequest()
        
        do {
            let results = try context.fetch(fetchRequest)
            if results.isEmpty {
                print("Данных в таблице нет")
            } else {
                return results.map({ ProductListModel.init(wihtProductListItem: $0)})
            }
        } catch {
            print(error.localizedDescription)
        }
        
        return [ProductListModel]()
    }
    
    func deleteFromProductList(wihtURL url: String) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ProductList")
        fetchRequest.predicate = NSPredicate(format: "externalLink = %@", url)

        do {
            let results = try context.fetch(fetchRequest)
            if results.isEmpty {
                
            } else {
                let _ = results.map({context.delete($0 as! NSManagedObject)})
                try context.save()
            }
        } catch {
            return
        }
    }
    
    func checkInProductList(wihtURL url: String) -> Bool {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ProductList")
        fetchRequest.predicate = NSPredicate(format: "externalLink = %@", url)

        do {
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
    
    func updatePriceHistoryItem(withItem item: ProductListModel) {
        ProductListNetworkManager.featchWBProductList(withURL: item.externalLink, completion: { (productArray) in
            guard let item = productArray else { return }

            DispatchQueue.main.async {
                self.updadaItem(withItem: item, updataUI: true)
            }
        })
    }
    
    func updadaItem(withItem item: ProductListModel, updataUI: Bool = false) {
        guard let entityHistory = NSEntityDescription.entity(forEntityName: "HistoryPrice", in: context) else { return }
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ProductList")
        fetchRequest.predicate = NSPredicate(format: "externalLink = %@", item.externalLink)

        do {
            let results = try context.fetch(fetchRequest) as? [ProductList]
            if !results!.isEmpty {
                let updataItem = results?.first
                updataItem!.id = Int64(item.id)
                updataItem!.name = item.name
                updataItem!.image = item.image
                updataItem!.externalLink = item.externalLink
                updataItem!.percent = Int16(item.percent)
                updataItem!.price = item.price
                updataItem!.rating = Int16(item.rating)
                updataItem!.sale = item.sale

                let _ = updataItem?.historyList.map({ updataItem?.removeFromHistoryList($0) })

                if let array = item.history {
                    for currentItem in array {
                        let newItemHistory = HistoryPrice(entity: entityHistory, insertInto: context)
                        newItemHistory.name = currentItem.name
                        newItemHistory.value = currentItem.value
                        updataItem!.addToHistoryList(newItemHistory)
                    }
                }
            }
        } catch {
            print(error.localizedDescription)
        }
        
        do {
            try context.save()
        
            if updataUI {
                NotificationCenter.default.post(name: NSNotification.Name("UpdateTable"), object: nil)
            }
        }
        catch {
            print("Saving Core Data Failed: \(error)")
        }
        
        
    }
    
    func updateAllItems() {
        let fetchRequest: NSFetchRequest<ProductList> = ProductList.fetchRequest()
        
        do {
            let results = try context.fetch(fetchRequest)
            if results.isEmpty {
                print("Данных в таблице нет")
            } else {
                let arrayItems: [String] = results.map({ $0.externalLink! })
                ProductListNetworkManager.featchWBProductList(withURL: arrayItems, completion: { (productArray) in
                    guard let items = productArray else { return }

                    DispatchQueue.main.async {
                        for item in items {
                            self.updadaItem(withItem: item)
                        }
                    }
                })
                
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}

