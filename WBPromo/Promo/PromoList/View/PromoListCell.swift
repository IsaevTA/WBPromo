//
//  PromoListCell.swift
//  WBPromo
//
//  Created by Timur Isaev on 27.11.2020.
//

import UIKit

class PromoListCell: UITableViewCell {

    @IBOutlet weak var contractTimeLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var saleLabel: UILabel!
    @IBOutlet weak var imagePromoView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    func configure(with comment: PromoListModel) {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        let result = formatter.string(from: date)
        
        let nextDate = Calendar.current.date(byAdding: .day, value: comment.controct_time, to: date)!
        let resultNextDate = formatter.string(from: nextDate)
        
        self.contractTimeLabel.text = "\(result) - \(resultNextDate)"
        self.nameLabel.text = comment.name
        
        let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: "\(getFormattMoney(withNUmber: comment.price))")
        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSMakeRange(0, attributeString.length))
        self.priceLabel.attributedText = attributeString;

        self.saleLabel.text = "\(getFormattMoney(withNUmber: comment.sale))"
        
        fetchImage(withURLString: comment.image)
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

    private func getFormattMoney(withNUmber number: Int) -> String {
        return "\(number) руб."
    }
}
