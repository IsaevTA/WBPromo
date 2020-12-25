//
//  ResulеTestView.swift
//  SaleMarket
//
//  Created by UserDev on 25.12.2020.
//

import UIKit

class ResultTestView: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var resultImage: UIImageView!
    @IBOutlet weak var resultDescriptionLabel: UILabel!
    
    let nameXib = "ResultTestView"
    
    init(frame: CGRect, currentTest: TestModel, resultTest: Int) {
        super.init(frame: frame)
        
        UINib(nibName: nameXib, bundle: nil).instantiate(withOwner: self, options: nil)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(contentView)

        contentView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        setupUI()
    }
    
    private func setupUI() {
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
