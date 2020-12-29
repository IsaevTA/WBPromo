//
//  PromoListCell.swift
//  SaleMarket
//
//  Created by Timur Isaev on 27.11.2020.
//

import UIKit
import NVActivityIndicatorView

class ProductListCell: UITableViewCell {

    @IBOutlet weak var viewCell: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var saleLabel: UILabel!
    @IBOutlet weak var imagePromoView: UIImageView!
    @IBOutlet weak var percentLabel: UILabel!
    @IBOutlet weak var favoritesImage: UIImageView!
    
    var activityIndicator: NVActivityIndicatorView!
    
    func configure(with itemCell: ProductListModel) {
        
        if self.activityIndicator == nil {
            self.activityIndicator = createActivitiIndicator(view: self, viewCenter: self.imagePromoView.center, widhtHeight: 20, typeActivity: .ballClipRotateMultiple, color: UIColor(red: 0.491, green: 0, blue: 0.722, alpha: 1))
        }
        activityIndicator.startAnimating()
        
        self.nameLabel.text = itemCell.name
        
        let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: "\(getFormattMoney(withNUmber: itemCell.price))")
        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSMakeRange(0, attributeString.length))
        self.priceLabel.attributedText = attributeString;
        
        self.saleLabel.text = "\(getFormattMoney(withNUmber: itemCell.sale))"
        self.percentLabel.text = "-\(itemCell.percent)%"
        
        self.viewCell.layer.cornerRadius = 5
        self.viewCell.layer.borderWidth = 1
        self.viewCell.layer.borderColor = UIColor(red: 0.937, green: 0.937, blue: 0.957, alpha: 1).cgColor
        
        if FavoritesManager.shared.checkFovarite(withId: itemCell.id) {
            self.favoritesImage.image = UIImage.returnImageStarFill()
        } else {
            self.favoritesImage.image = UIImage.returnImageStar()
        }
    }

    private func getFormattMoney(withNUmber number: Float) -> String {
        return "\(number) руб."
    }
}
