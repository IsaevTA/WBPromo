//
//  PromoListCell.swift
//  SaleMarket
//
//  Created by Timur Isaev on 27.11.2020.
//

import UIKit
import NVActivityIndicatorView

class ProductListCell: UITableViewCell {

    @IBOutlet weak var chartView: UIView!
    @IBOutlet weak var heighChartView: NSLayoutConstraint!
    
    @IBOutlet weak var viewCell: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var saleLabel: UILabel!
    @IBOutlet weak var imagePromoView: UIImageView!
    @IBOutlet weak var percentLabel: UILabel!
    @IBOutlet weak var favoritesImage: UIImageView!
    @IBOutlet weak var ratingStackView: RatingStackView!
    
    var showChartPriceBool = false
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

        if itemCell.price != 0 {
            self.priceLabel.isHidden = false
        } else {
            self.priceLabel.isHidden = true
        }
        
        if itemCell.percent != 0 {
            self.percentLabel.text = "-\(itemCell.percent)%"
            self.percentLabel.isHidden = false
        } else {
            self.percentLabel.isHidden = true
        }
        
        self.viewCell.layer.cornerRadius = 5
        self.viewCell.layer.borderWidth = 1
        self.viewCell.layer.borderColor = UIColor(red: 0.937, green: 0.937, blue: 0.957, alpha: 1).cgColor
        
        self.ratingStackView.starsRating = itemCell.rating
        
        self.favoritesImage.isHidden = true
//        if FavoritesManager.shared.checkFovarite(withId: itemCell.id) {
//            self.favoritesImage.image = UIImage.returnImageStarFill()
//        } else {
//            self.favoritesImage.image = UIImage.returnImageStar()
//        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(closeChart), name: NSNotification.Name(rawValue: "CloseChartView"), object: nil)
    }

    @IBAction func actionShowChartButton(_ sender: UIButton) {
        showChartPriceBool = !showChartPriceBool
        updateUIChart()
    }

    @objc func closeChart() {
        updateUIChart()
    }
    
    private func updateUIChart() {
        
        if showChartPriceBool {
            showChartView()
        } else {
            chartView.removeAllSubView()
            heighChartView.constant = 0
        }
        
        NotificationCenter.default.post(name: NSNotification.Name("UpdateTable"), object: nil)
    }
    
    private func getFormattMoney(withNUmber number: Float) -> String {
        return "\(number) руб."
    }
    
    private func setConstraintAndReturnRect() -> CGRect {
        var height: CGFloat = 0
        if showChartPriceBool {
            height = 240
        }
        
        heighChartView.constant = height
        let rect = CGRect(x: 0, y: 0, width: chartView.frame.size.width, height: CGFloat(height))
        
        return rect
    }
    
    private func showChartView() {
        let view = ChartPriceProductCell(frame: setConstraintAndReturnRect(), cell: self)
        chartView.addSubview(view)
    }
}

