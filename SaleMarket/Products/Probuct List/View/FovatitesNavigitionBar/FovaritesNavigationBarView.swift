//
//  FovaritesNavigationBarView.swift
//  SaleMarket
//
//  Created by UserDev on 15.12.2020.
//

import UIKit

class FovaritesNavigationBarView: UIView {
    @IBOutlet var view: UIView!
    @IBOutlet weak var counLabel: UILabel!
    
    init(frame: CGRect, count: Int) {
        super.init(frame: frame)
        UINib(nibName: "FovatitesNavigitionBar", bundle: nil).instantiate(withOwner: self, options: nil)
        addSubview(view)
        view.frame = self.bounds

        counLabel.text = String(count)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
