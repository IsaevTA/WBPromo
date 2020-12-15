//
//  PromoListCell.swift
//  WBPromo
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
    @IBOutlet weak var favoriteImage: UIImageView!
    
    var activityIndicatorView: NVActivityIndicatorView! = nil
    
    let starImage = UIImage(named: "heart")
    let starFillImage = UIImage(named: "heartfill")
    
    func configure(with itemCell: ProductListModel) {
        
        if self.activityIndicatorView == nil {
            let viewCenter = self.imagePromoView.center
            let frame = CGRect(x: viewCenter.x - 10, y: viewCenter.y - 10, width: 20, height: 20)
            activityIndicatorView = NVActivityIndicatorView(frame: frame, type: .ballClipRotateMultiple, color: UIColor(red: 0.491, green: 0, blue: 0.722, alpha: 1))
            activityIndicatorView.tag = itemCell.id
            self.addSubview(activityIndicatorView)
        }
        
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
            self.favoriteImage.image = starFillImage
        } else {
            self.favoriteImage.image = starImage
        }
        
        activityIndicatorView.startAnimating()
    }

    private func getFormattMoney(withNUmber number: Float) -> String {
        return "\(number) руб."
    }
}
