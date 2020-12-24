//
//  RadioButton.swift
//  SaleMarket
//
//  Created by Timur Isaev on 24.12.2020.
//

import Foundation
import UIKit

class RadioButton: UIButton {

    fileprivate let checkedImage = UIImage(named: "checkBox-On")
    fileprivate let uncheckedImage = UIImage(named: "checkBox-Off")

    override var isSelected: Bool {
        didSet{
            if isSelected == true {
                self.setImage(checkedImage, for: .normal)
            } else {
                self.setImage(uncheckedImage, for: .normal)
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    override func prepareForInterfaceBuilder() {
        initialize()
    }

    fileprivate func initialize() {
        self.isSelected = false
    }
}
