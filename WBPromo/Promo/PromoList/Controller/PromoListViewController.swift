//
//  ViewController.swift
//  WBPromo
//
//  Created by Timur Isaev on 27.11.2020.
//

import UIKit

class PromoListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var promoListArray = [PromoListModel]()
    var promoListArrayVisable = [PromoListModel]()
    lazy var searchBar = UISearchBar(frame: CGRect.zero)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.placeholder = "Я ищу"
        searchBar.delegate = self
        
        navigationItem.titleView = searchBar

        featchData()
    }
    
    private func featchData() {
        PromoListNetworkManager.getPromoList { (promoArray) in
            DispatchQueue.main.async {
                self.promoListArray = promoArray
                self.promoListArrayVisable = self.promoListArray
                self.tableView.reloadData()
            }
        }
    }
}

extension PromoListViewController: UITableViewDelegate {}

extension PromoListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return promoListArrayVisable.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PromoCell", for: indexPath) as! PromoListCell
        let promo = promoListArrayVisable[indexPath.row]
        cell.configure(with: promo)
        return cell
    }
}

extension PromoListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filterContentForSearchText(searchText: searchText)
    }
    
    private func filterContentForSearchText(searchText: String?) {
        if promoListArray.count == 0 { return }
        if let searchText = searchText {
            promoListArrayVisable = searchText.isEmpty ? promoListArray : promoListArray.filter  { ($0.name.localizedCaseInsensitiveContains(searchText)) }
            tableView.reloadData()
        }
    }
}
