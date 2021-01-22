//
//  ProductListViewController+UITableView.swift
//  SaleMarket
//
//  Created by Timur Isaev on 18.12.2020.
//

import UIKit

extension ProductListViewController: UITableViewDelegate {  }

extension ProductListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productListArrayVisable.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductListCell", for: indexPath) as! ProductListCell
        let promo = productListArrayVisable[indexPath.row]
        cell.configure(with: promo)
        if let imageData = promo.image {
            cell.imagePromoView.image = UIImage(data: imageData)
        } else {
            cell.activityIndicator.startAnimating()
            imageLoader.obtainImageWithPath(imagePath: promo.urlImage) { (image) in
                if let updateCell = tableView.cellForRow(at: indexPath) as? ProductListCell {
                    updateCell.imagePromoView.image = image
                    updateCell.activityIndicator?.stopAnimating()
                }
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let TrashAction = UIContextualAction(style: .normal, title:  "Удалить из избранного", handler: { [self] (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            print("Deleted from favorites")
            
            let item = productListArrayVisable[indexPath.row]
            CoreDataManager.shared.deleteFromProductList(wihtURL: item.externalLink)
            productListArrayVisable.remove(at: indexPath.row)
            tableView.reloadData()

            success(true)
        })
        TrashAction.backgroundColor = .red

        if currentTypeList == .home {
            return UISwipeActionsConfiguration(actions: [TrashAction])
        } else {
            return UISwipeActionsConfiguration(actions: [])
        }
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {

        let closeAction = UIContextualAction(style: .normal, title:  "Добавить в избранное", handler: { [self] (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            let item = productListArrayVisable[indexPath.row]
//            CoreDataManager.shared.saveProductList(withUrlProduct: item.externalLink, updateUI: false)
            CoreDataManager.shared.saveProductList(withProductItem: item, updateUI: true)
            CoreDataManager.shared.updatePriceHistoryItem(withItem: item)
            success(true)
        })
        
        closeAction.backgroundColor = UIColor(red: 0.725, green: 0, blue: 0.908, alpha: 1)
        
        if currentTypeList == .home {
            return UISwipeActionsConfiguration(actions: [])
        } else {
            return UISwipeActionsConfiguration(actions: [closeAction])
        }
    }
}
