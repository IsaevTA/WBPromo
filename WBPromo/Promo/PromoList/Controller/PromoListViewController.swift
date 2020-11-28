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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        PromoListNetworkManager.getPromoList { (promoArray) in
            DispatchQueue.main.async {
                self.promoListArray = promoArray
                self.tableView.reloadData()                
            }
        }
    }
}

extension PromoListViewController: UITableViewDelegate {}

extension PromoListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return promoListArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PromoCell", for: indexPath) as! PromoListCell
        let promo = promoListArray[indexPath.row]
        cell.configure(with: promo)
        return cell
    }
}
