//
//  NavigationBar.swift
//  Custom Navigation Bar
//
//  Created by Michael Tseitlin on 08.12.2019.
//  Copyright © 2019 Michael Tseitlin. All rights reserved.
//

import UIKit

@objc protocol NavigationBarDelegate: class {
    @objc optional func leftAction()
    @objc optional func rightAction()
}

@IBDesignable
class NavigationBar: UIView {
    
    weak var delegate: NavigationBarDelegate?
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        let bundle = Bundle(for: NavigationBar.self)
        bundle.loadNibNamed("NavigationBar", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
    @IBAction func goBack(_ sender: UIButton) {
        delegate?.leftAction?()
    }
    
    @IBAction func goNext(_ sender: UIButton) {
        delegate?.rightAction?()
    }
}
