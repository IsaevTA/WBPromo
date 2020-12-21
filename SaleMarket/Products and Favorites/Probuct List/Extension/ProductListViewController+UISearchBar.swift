//
//  ProductListViewController+UISearchBar.swift
//  SaleMarket
//
//  Created by UserDev on 18.12.2020.
//

import UIKit

extension ProductListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filterContentForSearchText(searchText: searchText)
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
        searchBar.text = ""
        filterContentForSearchText(searchText: "")
        hideNotFoundView()
    }
    
    private func showNotFoundView() {
        let rect = CGRect(x: 0, y: 0, width: self.tableView.frame.size.width, height: self.tableView.frame.size.height)
        let view = NotFoundView(frame: rect)
        self.view.addSubview(view)
    }
    
    private func hideNotFoundView() {
        let notFoundViews = self.view.subviews.filter{$0 is NotFoundView}
        for view in notFoundViews {
            view.removeFromSuperview()
        }
    }
    
    private func filterContentForSearchText(searchText: String?) {
        if productListArray.count == 0 { return }
        if let searchText = searchText {
            productListArrayVisable = searchText.isEmpty ? productListArray : productListArray.filter  { ($0.name.localizedCaseInsensitiveContains(searchText)) }
            tableView.reloadData()
            if productListArrayVisable.count == 0 {
                showNotFoundView()
            } else {
                hideNotFoundView()
            }
        }
    }
}
