//
//  ProductListViewController+UITableView.swift
//  SaleMarket
//
//  Created by UserDev on 18.12.2020.
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
        imageLoader.obtainImageWithPath(imagePath: promo.image) { (image) in
            if let updateCell = tableView.cellForRow(at: indexPath) as? ProductListCell {
                updateCell.imagePromoView.image = image
                updateCell.activityIndicator?.stopAnimating()
            }
        }
        return cell
    }
}
