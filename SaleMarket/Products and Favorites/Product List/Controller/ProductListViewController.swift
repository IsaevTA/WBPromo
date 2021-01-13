//
//  ViewController.swift
//  SaleMarket
//
//  Created by Timur Isaev on 27.11.2020.
//

import UIKit
import NVActivityIndicatorView

class ProductListViewController: UIViewController {

    enum TypeNavigationProductList: Int {
        case wbProductList = 44
        case productList = 80
        case favoritesList = 90
        case searchList = 88
    }
    
    enum SelectedTab: Int {
        case home = 0
        case fire = 1
        case favorite = 2
    }
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var topViewConstraint: NSLayoutConstraint!
    @IBOutlet weak var newsView: UIView!
    @IBOutlet weak var newsViewConstraint: NSLayoutConstraint!
    
    var activityIndicator: NVActivityIndicatorView!
    var wbProdictList = [ProductListModel]()
    var productListArray = [ProductListModel]()
    var productListArrayVisable = [ProductListModel]()
    var openProductIndex = -1
    var imageLoader = ImageLoader()
    
    var currentTypeNagigation: TypeNavigationProductList = .productList
    var currentTypeList: SelectedTab = .home
    
    var searchText = ""
    
    var currentNews: NewsModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicator = createActivitiIndicator(view: self.view, viewCenter: self.view.center, widhtHeight: 100, typeActivity: .ballPulse, color: UIColor(red: 0.491, green: 0, blue: 0.722, alpha: 1))
        activityIndicator.startAnimating()
        
        createNewsView()
    
        NotificationCenter.default.addObserver(self, selector: #selector(openProduct(notification:)), name: NSNotification.Name(rawValue: "OpenProduct"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(openNews(notification:)), name: NSNotification.Name(rawValue: "OpenNews"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateTable), name: NSNotification.Name(rawValue: "UpdateTable"), object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        showAndHideTabBar(hide: false)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        switch tabBarController?.selectedIndex {
        case 0: currentTypeList = .home
        case 1: currentTypeList = .fire
        case 2: currentTypeList = .favorite
        default:
            break
        }
        
        if currentTypeList == .favorite {
            currentTypeNagigation = .favoritesList
        } else if currentTypeList == .home {
            currentTypeNagigation = .wbProductList
        } else {
            if searchText == "" {
                currentTypeNagigation = .productList
            } else {
                currentTypeNagigation = .searchList
            }
        }
        
        updataNavigationBar()
        //featchData(wihtTypeList: currentTypeNagigation)
        if currentTypeList == .home {
            featchDataWBProduct()
        } else {
            featchDataOutProduct()
        }
        
        if !SettingsAnalist.shared.firstStartForHelp {
            self.performSegue(withIdentifier: "showHelp", sender: self)
            SettingsAnalist.shared.firstStartForHelp = true
        }
    }
    
    @objc func openProduct(notification: Notification) {
        if let idProduct = notification.userInfo?["idProduct"] as? Int {
            openProductIndex = idProduct
            self.performSegue(withIdentifier: "showProduct", sender: self)
        }
    }
    
    @objc func openNews(notification: Notification) {
        if let news = notification.userInfo?["currentNews"] as? NewsModel {
            SettingsGlobal.shared.showNowNews = true
            currentNews = news
            if news.type == .news {
                self.performSegue(withIdentifier: "showNewsInWeb", sender: self)
            } else if news.type == .test {
                self.performSegue(withIdentifier: "showTestView", sender: self)
            }
        }
    }
    
    @objc func updateTable() {
        featchDataWBProduct()
        tabBarController?.selectedIndex = SelectedTab.home.rawValue
    }
    
    private func setConstraintAndReturnRect(wihtHeight height: Int) -> CGRect {
        topViewConstraint.constant = CGFloat(height)
        let rect = CGRect(x: 0, y: 0, width: topView.frame.size.width, height: CGFloat(height))
        
        return rect
    }
    
    private func showAndHideNewsView(hide: Bool) {
        if hide {
            newsViewConstraint.constant = 0
            newsView.isHidden = true
        } else {
            newsViewConstraint.constant = 190
            newsView.isHidden = false
        }
    }
    
    private func showAndHideTabBar(hide: Bool) {
        tabBarController?.tabBar.isHidden = hide
    }
    
    private func updataNavigationBar() {
        
        topView.removeAllSubView()
        if currentTypeList == .home {
            let view = DefaultNavigationBar(frame: setConstraintAndReturnRect(wihtHeight: currentTypeNagigation.rawValue), title: "Список товаров")
            view.rightButton.isHidden = true
            
            let starImage = UIImage(systemName: "info.circle")
            view.leftButton.setImage(starImage, for: .normal)
            view.delegate = self

            topView.addSubview(view)
            showAndHideNewsView(hide: false)
        } else {
            if currentTypeNagigation == .favoritesList {
                let view = FavoritesNavigationBar(frame: setConstraintAndReturnRect(wihtHeight: currentTypeNagigation.rawValue), count: 0)
                topView.addSubview(view)
                showAndHideTabBar(hide: false)
                showAndHideNewsView(hide: true)
            } else if currentTypeNagigation == .productList {
                let view = SearchNavigationBar(frame: setConstraintAndReturnRect(wihtHeight: currentTypeNagigation.rawValue))
                view.delegate = self
                topView.addSubview(view)
                showAndHideTabBar(hide: false)
                showAndHideNewsView(hide: true)
            } else if currentTypeNagigation == .searchList {
                let view = ResultNavigationBar(frame: setConstraintAndReturnRect(wihtHeight: currentTypeNagigation.rawValue),
                                               searchWord: searchText,
                                               count: productListArrayVisable.count)
                view.delegate = self
                topView.addSubview(view)
                showAndHideTabBar(hide: true)
                showAndHideNewsView(hide: true)
            }
        }
    }
    
    private func createNewsView() {
        newsViewConstraint.constant = 190
        let rect = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 190)
        let view = NewsCollectionView(frame: rect, arrayNews: featchNewsData())
        newsView.addSubview(view)
    }
    
    private func featchDataOutProduct() {
        ProductListNetworkManager.getProductList { (productArray) in
            guard let productArray = productArray else {
                self.showAlert(withTitle: "Ошибка", withMessage: "Ошибка при получении данных. Повторите попытку позже.")
                self.activityIndicator.stopAnimating()
                return
            }
            
            DispatchQueue.main.async { [unowned self] in
                self.productListArray = productArray
                
                if currentTypeNagigation == .favoritesList {
                    let arrayFavorite = FavoritesManager.shared.favoritesProduct
                    productListArrayVisable = productListArray.filter({arrayFavorite.contains($0.id)})
                    NotificationCenter.default.post(name: NSNotification.Name("UpdateCountFavorite"),
                                                    object: nil,
                                                    userInfo: ["count": productListArrayVisable.count])
                } else if currentTypeNagigation == .searchList {
                    filterContentForSearchText(searchText: searchText)
                } else {
                    productListArrayVisable = productListArray
                }
                
                tableView.reloadData()
                activityIndicator.stopAnimating()
            }
        }
    }
    
    private func featchDataWBProduct() {
        ProductListNetworkManager.featchWBProductList { (productArray) in
            guard let productArray = productArray else {
                self.showAlert(withTitle: "Ошибка", withMessage: "Ошибка при получении данных. Повторите попытку позже.")
                self.activityIndicator.stopAnimating()
                return
            }
            
            DispatchQueue.main.async { [unowned self] in
                
                if productArray.count != 0 {
                    hideEmptyView()
                    self.wbProdictList = productArray.sorted(by: { $0.name < $1.name })
                    productListArray = self.wbProdictList
                    productListArrayVisable = productListArray
                    tableView.reloadData()
                } else {
                    showEmptyView()
                }
                
                self.activityIndicator.stopAnimating()
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
                    detailViewController.urlProduct = product.url
                }
            } else {
                let detailViewController = segue.destination as! ProductViewController
                detailViewController.idProduct = openProductIndex
                openProductIndex = -1
            }
        } else if segue.identifier == "showNewsInWeb" {
            let webViewController = segue.destination as! WebViewController
            webViewController.currentNews = currentNews
        }  else if segue.identifier == "showTestView" {
            let testViewController = segue.destination as! TestViewController
            testViewController.currentNewsTest = currentNews
        }
    }
    
    // MARK: - Filter function
    
    private func filterContentForSearchText(searchText: String?) {
        hideNotFoundView()
        self.searchText = ""
        if searchText == "" {
            currentTypeNagigation = .productList
            productListArrayVisable = productListArray
            tableView.reloadData()
        } else {
            currentTypeNagigation = .searchList
            if productListArray.count == 0 { return }
            
            if let searchString = searchText {
                self.searchText = searchString
                productListArrayVisable = searchString.isEmpty ? productListArray : productListArray.filter  { ($0.name.localizedCaseInsensitiveContains(searchString)) }
                tableView.reloadData()
                if productListArrayVisable.count == 0 {
                    showNotFoundView()
                }
            }
        }
        updataNavigationBar()
    }
    
    // MARK: - Show and hide view not found view
    
    private func showNotFoundView() {
        let rect = CGRect(x: 0, y: 0, width: self.tableView.frame.size.width, height: self.tableView.frame.size.height)
        let view = NotFoundView(frame: rect)
        view.delegate = self
        self.view.addSubview(view)
    }

    private func hideNotFoundView() {
        let notFoundViews = self.view.subviews.filter{$0 is NotFoundView}
        for view in notFoundViews {
            view.removeFromSuperview()
        }
    }
    
    private func showEmptyView() {
        let view = EmptyView(frame: self.tableView.frame)
        self.view.addSubview(view)
    }

    private func hideEmptyView() {
        let notFoundViews = self.view.subviews.filter{$0 is EmptyView}
        for view in notFoundViews {
            view.removeFromSuperview()
        }
    }
}

extension ProductListViewController: CustomNavigationBarDelegate {
    func searchNavigationBar(searchText: String) {
        filterContentForSearchText(searchText: searchText)
    }
    
    func backToHome() {
        filterContentForSearchText(searchText: "")
    }
}

extension ProductListViewController: DefaultNavigationBarDelegate {
    func leftAction() {
        self.performSegue(withIdentifier: "showHelp", sender: self)
    }
}
