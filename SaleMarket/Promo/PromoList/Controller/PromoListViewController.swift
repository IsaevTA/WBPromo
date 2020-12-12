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
    var searchBar = UISearchBar(frame: CGRect.zero)
    
    var openPromoIndex = -1
    var imageLoader = ImageLoader()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.placeholder = "Я ищу"
        searchBar.delegate = self
        
        navigationItem.titleView = searchBar

        featchData()
        
        NotificationCenter.default.addObserver(self, selector: #selector(openPromo(notification:)), name: NSNotification.Name(rawValue: "OpenPromo"), object: nil)
    }
    
    @objc func openPromo(notification: Notification) {
        if let promo = notification.userInfo?["idPromo"] as? Int {
            openPromoIndex = promo
            self.performSegue(withIdentifier: "showDetail", sender: self)
        }
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
    
    // MARK: - Segues
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if openPromoIndex == -1 {
                if let indexPath = self.tableView.indexPathForSelectedRow {
                    let promo = promoListArrayVisable[indexPath.row]
                    let detailViewController = segue.destination as! DetailViewController
                    detailViewController.idPromo = promo.id
                }
            } else {
                let detailViewController = segue.destination as! DetailViewController
                detailViewController.idPromo = openPromoIndex
                openPromoIndex = -1
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
        cell.activityIndicator.isHidden = false
        cell.activityIndicator.startAnimating()
        let promo = promoListArrayVisable[indexPath.row]
        cell.configure(with: promo)
        imageLoader.obtainImageWithPath(imagePath: promo.image) { (image) in
            if let updateCell = tableView.cellForRow(at: indexPath) as? PromoListCell {
                updateCell.imagePromoView.image = image
                updateCell.activityIndicator.isHidden = true
                updateCell.activityIndicator.stopAnimating()
            }
        }
        return cell
    }
}

extension PromoListViewController: UISearchBarDelegate {
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
    }
    
    private func filterContentForSearchText(searchText: String?) {
        if promoListArray.count == 0 { return }
        if let searchText = searchText {
            promoListArrayVisable = searchText.isEmpty ? promoListArray : promoListArray.filter  { ($0.name.localizedCaseInsensitiveContains(searchText)) }
            tableView.reloadData()
        }
    }
}
