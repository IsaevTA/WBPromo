//
//  EmptyView.swift
//  SaleMarket
//
//  Created by UserDev on 12.01.2021.
//

import UIKit

class EmptyView: UIView {

    @IBOutlet var contentView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        UINib(nibName: "EmptyView", bundle: nil).instantiate(withOwner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
