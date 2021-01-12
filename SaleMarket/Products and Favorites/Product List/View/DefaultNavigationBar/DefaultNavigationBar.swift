//
//  DefaultNavigationBar.swift
//  SaleMarket
//
//  Created by UserDev on 12.01.2021.
//

import UIKit

@objc protocol DefaultNavigationBarDelegate: class {
    @objc optional func leftAction()
    @objc optional func rightAction()
}

class DefaultNavigationBar: UIView {

    weak var delegate: DefaultNavigationBarDelegate?
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!
    
    let nameXib = "DefaultNavigationBar"
    
    init(frame: CGRect, title: String) {
        super.init(frame: frame)
        UINib(nibName: nameXib, bundle: nil).instantiate(withOwner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds

        titleLabel.text = String(title)
    }
    
    @IBAction func actionLeftButton(_ sender: UIButton) {
        delegate?.leftAction?()
    }
    
    @IBAction func actionRightButton(_ sender: UIButton) {
        delegate?.rightAction?()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
