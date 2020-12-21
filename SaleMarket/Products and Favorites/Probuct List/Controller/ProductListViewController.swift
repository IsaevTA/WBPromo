//
//  ViewController.swift
//  SaleMarket
//
//  Created by Timur Isaev on 27.11.2020.
//

import UIKit
import NVActivityIndicatorView

class ProductListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var topViewConstraint: NSLayoutConstraint!
    @IBOutlet weak var newsView: UIView!
    @IBOutlet weak var newsViewConstraint: NSLayoutConstraint!
    
    var activityIndicator: NVActivityIndicatorView!
    var productListArray = [ProductListModel]()
    var productListArrayVisable = [ProductListModel]()
//    var searchBar = UISearchBar(frame: CGRect.zero)
    var openProductIndex = -1
    var imageLoader = ImageLoader()
    var isFovatites: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicator = createActivitiIndicator(view: self.view, viewCenter: self.view.center, widhtHeight: 100, typeActivity: .ballPulse)
        activityIndicator.startAnimating()
        
        newsViewConstraint.constant = 140
        
        let rect = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 140)
        let view = NewsCollectionView(frame: rect, arrayNews: ["Test 1", "Test 2", "Test 3", "Test 4", "Test 5", "Test 6", "Test 7", "Test 8", "Test 9", "Test 10"])
        newsView.addSubview(view)
    
        
        NotificationCenter.default.addObserver(self, selector: #selector(openProduct(notification:)), name: NSNotification.Name(rawValue: "OpenProduct"), object: nil)
    }
    
    func createNavigationBar() {
//        topView.isHidden = !isFovatites
        topView.removeAllSubView()
        if isFovatites {
//            if (topView.subviews.first as? FavoritesNavigationBar) == nil {
                topViewConstraint.constant = 90
                let rect = CGRect(x: 0, y: 0, width: topView.frame.size.width, height: 90)
                let view = FavoritesNavigationBar(frame: rect, count: 0)
                topView.addSubview(view)
//            }
        } else {
            
            topViewConstraint.constant = 80
            let rect = CGRect(x: 0, y: 0, width: topView.frame.size.width, height: 80)
            let view = SearchNavigationBar(frame: rect)
            view.delegate = self
            topView.addSubview(view)
            
//            searchBar.placeholder = "Я ищу"
//            searchBar.delegate = self
//            navigationItem.titleView = searchBar
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

//        navigationController?.setNavigationBarHidden(isFovatites, animated: animated)
        tabBarController?.tabBar.isHidden = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        isFovatites = tabBarController?.selectedIndex == 1 ? true : false
//        navigationController?.setNavigationBarHidden(isFovatites, animated: animated)
        createNavigationBar()
        featchData(wihtFavoriteUse: isFovatites)
    }
    
    @objc func openProduct(notification: Notification) {
        if let idProduct = notification.userInfo?["idProduct"] as? Int {
            openProductIndex = idProduct
            self.performSegue(withIdentifier: "showProduct", sender: self)
        }
    }
    
    private func featchData(wihtFavoriteUse favorite: Bool) {
        ProductListNetworkManager.getProductList { (productArray) in
            guard let productArray = productArray else {
                self.showAlert(withTitle: "Ошибка", withMessage: "Ошибка при получении данных. Повторите попытку позже.")
                self.activityIndicator.stopAnimating()
                return
            }
            
            DispatchQueue.main.async { [unowned self] in
                self.productListArray = productArray
                
                if favorite {
                    let arrayFavorite = FavoritesManager.shared.favoritesProduct
                    productListArrayVisable = productListArray.filter({arrayFavorite.contains($0.id)})
                    NotificationCenter.default.post(name: NSNotification.Name("UpdateCountFavorite"),
                                                    object: nil,
                                                    userInfo: ["count": productListArrayVisable.count])
                } else {
                    productListArrayVisable = productListArray
                }
                
                tableView.reloadData()
                activityIndicator.stopAnimating()
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
        } else if segue.identifier == "showSearch" {
            
        }
    }
}

extension ProductListViewController: SearchNavigationBarDelegat {
    func backToHome() {
        filterContentForSearchText(searchText: "")
    }
    
    func searchNavigationBar(searchText: String) {
        self.performSegue(withIdentifier: "showSearch", sender: self)
        //filterContentForSearchText(searchText: searchText)
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
