//
//  NavigationBar.swift
//  SaleMarket
//
//  Created by Timur Isaev on 22.12.2020.
//

import UIKit

class ResultNavigationBar: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var downView: UIView!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var searchWordLabel: UILabel!
    
    weak var delegate: CustomNavigationBarDelegate?
    
    init(frame: CGRect, searchWord: String, count: Int) {
        super.init(frame: frame)
        UINib(nibName: "ResultNavigationBar", bundle: nil).instantiate(withOwner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        
        searchWordLabel.text = searchWord
        searchWordLabel.sizeToFit()
        countLabel.text = String(count)
        countLabel.sizeToFit()
        
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        //Настрока тени
        topView.layer.shadowColor = UIColor.lightGray.cgColor
        topView.layer.shadowRadius = 2.0
        topView.layer.shadowOpacity = 0.35
        topView.layer.shadowOffset = CGSize(width: 0, height: 3)
        topView.layer.masksToBounds = false
        
    }
    
    @IBAction func actionBackToHomeButton(_ sender: UIButton) {
        delegate?.backToHome()
    }
}
