//
//  NotFoundView.swift
//  SaleMarket
//
//  Created by UserDev on 18.12.2020.
//

import UIKit

class NotFoundView: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var topView: UIView!
    
    weak var delegate: CustomNavigationBarDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        UINib(nibName: "NotFoundView", bundle: nil).instantiate(withOwner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        setupUI()
    }
    
    private func setupUI() {
        //Настрока тени
        topView.layer.shadowColor = UIColor.lightGray.cgColor
        topView.layer.shadowRadius = 2.0
        topView.layer.shadowOpacity = 0.35
        topView.layer.shadowOffset = CGSize(width: 0, height: 3)
        topView.layer.masksToBounds = false
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBAction func actionBackToHomeButton(_ sender: UIButton) {
        delegate?.backToHome()
    }
}

