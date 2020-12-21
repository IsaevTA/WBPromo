//
//  NotFoundView.swift
//  SaleMarket
//
//  Created by UserDev on 18.12.2020.
//

import UIKit

class NotFoundView: UIView {
    
    @IBOutlet var contentView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        UINib(nibName: "NotFoundView", bundle: nil).instantiate(withOwner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
