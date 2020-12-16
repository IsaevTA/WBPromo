//
//  FovaritesNavigationBarView.swift
//  SaleMarket
//
//  Created by Timur Isaev on 15.12.2020.
//

import UIKit

class FavoritesNavigationBarView: UIView {
    @IBOutlet var view: UIView!
    @IBOutlet weak var counLabel: UILabel!
    
    init(frame: CGRect, count: Int) {
        super.init(frame: frame)
        UINib(nibName: "FavoritesNavigationBar", bundle: nil).instantiate(withOwner: self, options: nil)
        addSubview(view)
        view.frame = self.bounds

        counLabel.text = String(count)

        NotificationCenter.default.addObserver(self, selector: #selector(updateCount(notification:)), name: NSNotification.Name(rawValue: "UpdateCountFavorite"), object: nil)
    }
    
    @objc func updateCount(notification: Notification) {
        if let count = notification.userInfo?["count"] as? Int {
            self.counLabel.text = String(count)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
