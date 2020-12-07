//
//  PromoListCell.swift
//  WBPromo
//
//  Created by Timur Isaev on 27.11.2020.
//

import UIKit

class PromoListCell: UITableViewCell {

    @IBOutlet weak var viewCell: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var saleLabel: UILabel!
    @IBOutlet weak var imagePromoView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var percentLabel: UILabel!
    
    func configure(with itemCell: PromoListModel) {
        
        self.nameLabel.text = itemCell.name
        
        let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: "\(getFormattMoney(withNUmber: itemCell.price))")
        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSMakeRange(0, attributeString.length))
        self.priceLabel.attributedText = attributeString;

        self.saleLabel.text = "\(getFormattMoney(withNUmber: itemCell.sale))"
        self.percentLabel.text = "-\(itemCell.percent)%"
//        fetchImage(withURLString: itemCell.image)
        
        self.viewCell.layer.cornerRadius = 5
        self.viewCell.layer.borderWidth = 1
        self.viewCell.layer.borderColor = UIColor(red: 0.937, green: 0.937, blue: 0.957, alpha: 1).cgColor
    }
    
    fileprivate func fetchImage(withURLString urlString: String) {
        let imageURL = URL(string: urlString)
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        
        let queue = DispatchQueue.global(qos: .userInitiated)
        queue.async { [weak self] in
            guard let url = imageURL, let imageData = try? Data(contentsOf: url) else { return }
            DispatchQueue.main.async {
                self?.imagePromoView.image = UIImage(data: imageData)
                self?.activityIndicator.isHidden = true
                self?.activityIndicator.stopAnimating()
            }
        }
    }

    private func getFormattMoney(withNUmber number: Float) -> String {
        return "\(number) руб."
    }
}
