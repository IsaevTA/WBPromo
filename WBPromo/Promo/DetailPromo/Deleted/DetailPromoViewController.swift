//
//  DetailPromoViewController.swift
//  WBPromo
//
//  Created by Timur Isaev on 30.11.2020.
//

import UIKit

class DetailPromoViewController: UIViewController {

    var promoWithListPromo: PromoListModel?
    var currentPromo: InfoPromoModel?
    var imageNameArray = [String]()
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var titleNameLabel: UILabel!
    @IBOutlet weak var titleSaleLabel: UILabel!
    
//    @IBOutlet weak var nameLebel: UILabel!
    @IBOutlet weak var sliderCollectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    @IBOutlet weak var saleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var percentLabel: UILabel!
    @IBOutlet weak var ratingStackView: RatingStackView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        featchData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    private func featchData() {
        guard let promo = promoWithListPromo else { return }
        
        DetailPromoNetworkManager.getInfoPromo(withID: promo.id) { (infoPromo) in
            DispatchQueue.main.async {
                self.currentPromo = infoPromo
                self.imageNameArray = infoPromo.images
                self.sliderCollectionView.reloadData()
                self.updateUI(infoPromo: infoPromo)
            }
        }
    }
    
    private func updateUI(infoPromo item: InfoPromoModel) {
//        nameLebel.text = item.name
        titleNameLabel.text = item.name
        
        pageControl.numberOfPages = imageNameArray.count
        pageControl.currentPage = 0
        
        saleLabel.text = "\(getFormattMoney(withNUmber: item.sale))"
        titleSaleLabel.text = "\(getFormattMoney(withNUmber: item.sale))"
        
        let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: "\(getFormattMoney(withNUmber: item.price))")
        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSMakeRange(0, attributeString.length))
        priceLabel.attributedText = attributeString;

        percentLabel.text = "-\(item.percent)%"
        
        ratingStackView.starsRating = item.rating
        descriptionLabel.text = item.description
    }
    
    @IBAction func actionBackButton(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    private func getFormattMoney(withNUmber number: Float) -> String {
        return "\(number) руб."
    }
}

