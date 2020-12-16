//
//  ViewController.swift
//  WBPromo
//
//  Created by Timur Isaev on 27.11.2020.
//

import UIKit
import NVActivityIndicatorView

class ProductListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var topViewConstraint: NSLayoutConstraint!
    
    var activityIndicatorView: NVActivityIndicatorView! = nil
    
    var productListArray = [ProductListModel]()
    var productListArrayVisable = [ProductListModel]()
    var searchBar = UISearchBar(frame: CGRect.zero)
    
    var openProductIndex = -1
    var imageLoader = ImageLoader()
    
    var isFovatites: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let viewCenter = self.view.center
        let frame = CGRect(x: viewCenter.x - 50, y: viewCenter.y - 50, width: 100, height: 100)
        activityIndicatorView = NVActivityIndicatorView(frame: frame, type: .ballPulse, color: UIColor(red: 0.491, green: 0, blue: 0.722, alpha: 1))
        self.view.addSubview(activityIndicatorView)
        activityIndicatorView.startAnimating()
        
        NotificationCenter.default.addObserver(self, selector: #selector(openPromo(notification:)), name: NSNotification.Name(rawValue: "OpenPromo"), object: nil)
    }
    
    func createNavigationBar() {
        
        topView.isHidden = !isFovatites
        if isFovatites {
            if (topView.subviews.first as? FavoritesNavigationBarView) == nil {
                topViewConstraint.constant = 96
                
                let rect = CGRect(x: 0, y: 0, width: topView.frame.size.width, height: 90)
                let view = FavoritesNavigationBarView(frame: rect, count: 0)
                topView.addSubview(view)
            }
        } else {
            searchBar.placeholder = "Я ищу"
            searchBar.delegate = self
            navigationItem.titleView = searchBar
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        tabBarController?.tabBar.isHidden = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        isFovatites = tabBarController?.selectedIndex == 1 ? true : false
        navigationController?.setNavigationBarHidden(isFovatites, animated: animated)
        createNavigationBar()
        featchData(wihtFavoriteUse: isFovatites)
    }
    
    @objc func openPromo(notification: Notification) {
        if let promo = notification.userInfo?["idProduct"] as? Int {
            openProductIndex = promo
            self.performSegue(withIdentifier: "showProduct", sender: self)
        }
    }
    
    private func featchData(wihtFavoriteUse favorite: Bool) {
        ProductListNetworkManager.getPromoList { (promoArray) in
            DispatchQueue.main.async { [unowned self] in
                self.productListArray = promoArray
                
                if favorite {
                    let arrayFavorite = FavoritesManager.shared.favoritesProduct
                    self.productListArrayVisable = productListArray.filter({arrayFavorite.contains($0.id)})
                    NotificationCenter.default.post(name: NSNotification.Name("UpdateCountFavorite"),
                                                    object: nil,
                                                    userInfo: ["count": self.productListArrayVisable.count])
                } else {
                    self.productListArrayVisable = self.productListArray
                }
                
                self.tableView.reloadData()
                self.activityIndicatorView.stopAnimating()
            }
        }
    }
    
    // MARK: - Segues
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showProduct" {
            if openProductIndex == -1 {
                if let indexPath = self.tableView.indexPathForSelectedRow {
                    let product = productListArrayVisable[indexPath.row]
                    let detailViewController = segue.destination as! ProductViewController
                    detailViewController.idProduct = product.id
                }
            } else {
                let detailViewController = segue.destination as! ProductViewController
                detailViewController.idProduct = openProductIndex
                openProductIndex = -1
            }
        }
    }
}

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
                updateCell.activityIndicatorView?.stopAnimating()
            }
        }
        return cell
    }
}

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
    }
    
    private func filterContentForSearchText(searchText: String?) {
        if productListArray.count == 0 { return }
        if let searchText = searchText {
            productListArrayVisable = searchText.isEmpty ? productListArray : productListArray.filter  { ($0.name.localizedCaseInsensitiveContains(searchText)) }
            tableView.reloadData()
        }
    }
}
