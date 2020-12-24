//
//  CheckBox.swift
//  SaleMarket
//
//  Created by Timur Isaev on 24.12.2020.
//

import UIKit

class CheckBox: UIButton {
    // Images
    let checkedImage = UIImage(named: "checkBox-On")! as UIImage
    let uncheckedImage = UIImage(named: "checkBox-Off")! as UIImage

    // Bool property
    var isChecked: Bool = false {
        didSet{
            if isChecked == true {
                self.setImage(checkedImage, for: .normal)
            } else {
                self.setImage(uncheckedImage, for: .normal)
            }
        }
    }

    override func awakeFromNib() {
        self.addTarget(self, action: #selector(CheckBox.buttonClicked(sender:)), for: .touchUpInside)
        self.isChecked = false
    }

    @objc func buttonClicked(sender: UIButton) {
        if sender == self {
            isChecked = !isChecked
        }
    }
}
