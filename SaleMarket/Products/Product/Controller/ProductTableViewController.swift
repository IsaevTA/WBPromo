//
//  DetailTableViewController.swift
//  WBPromo
//
//  Created by Timur Isaev on 04.12.2020.
//

import UIKit

class ProductTableViewController: UITableViewController {

    let favoriteManager = FavoritesManager.shared
    
    @IBOutlet weak var saleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var percentLabel: UILabel!
    @IBOutlet weak var ratingStackView: RatingStackView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var equipmentLabel: UILabel!
    @IBOutlet weak var specificationLabel: UILabel!
    @IBOutlet weak var commentsStackView: CommentStackView!
    @IBOutlet weak var favoriteImageButton: UIButton!
    @IBOutlet weak var fovariteTextButton: UIButton!
    
    var heightStackView: CGFloat = 0
    var product: ProductModel?
    
    let starImage = UIImage(named: "heart")
    let starFillImage = UIImage(named: "heartfill")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.estimatedRowHeight = 800.0
        tableView.rowHeight = UITableView.automaticDimension
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateUI(notification:)), name: NSNotification.Name(rawValue: "FeatchPromo"), object: nil)
    }

    @objc func updateUI(notification: Notification) {
        if let product = notification.userInfo?["promo"] as? ProductModel {
            self.product = product
            self.updateUI(infoPromo: product)
        }
    }
    
    @IBAction func actionFavoriteBUtton(_ sender: UIButton) {
        if favoriteManager.checkFovarite(withId: product!.id) {
            favoriteManager.deleteFavorite(wihtId: product!.id)
        } else {
            favoriteManager.addFavorite(wihtId: product!.id)
        }
        
        updateFavoriteButton()
    }
    
    private func updateFavoriteButton() {
        let favoriteCheck = favoriteManager.checkFovarite(withId: product!.id)
        if favoriteCheck {
            favoriteImageButton.setImage(starFillImage, for: .normal)
            fovariteTextButton.setTitle("Добавлено в избранное", for: .normal)
        } else {
            favoriteImageButton.setImage(starImage, for: .normal)
            fovariteTextButton.setTitle("В избранное", for: .normal)
        }
    }
    
    private func updateUI(infoPromo item: ProductModel) {

        saleLabel.text = "\(getFormattMoney(withNUmber: item.sale))"
        
        let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: "\(getFormattMoney(withNUmber: item.price))")
        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSMakeRange(0, attributeString.length))
        priceLabel.attributedText = attributeString;

        percentLabel.text = "-\(item.percent)%"

        ratingStackView.starsRating = item.rating

        descriptionLabel.attributedText = setAttributeLineSpacingForLabel(withString: item.description, andSpacing: 4)
        descriptionLabel.sizeToFit()

        equipmentLabel.attributedText = setAttributeLineSpacingForLabel(withString: convertDictionaryToString(withDictionary: item.equipment), andSpacing: 5)
        equipmentLabel.sizeToFit()

        specificationLabel.attributedText = setAttributeLineSpacingForLabel(withString: convertDictionaryToString(withDictionary: item.specification), andSpacing: 5)
        
        specificationLabel.sizeToFit()
        
        commentsStackView.frame.size.height = 0
        for itemComment in item.comments {
            commentsStackView.addItem(wihtComment: itemComment)
        }
        heightStackView = commentsStackView.frame.size.height
        
        updateFavoriteButton()
        
        tableView.reloadData()
    }
    
    private func convertDictionaryToString(withDictionary dictionary: [NameValueType]) -> String {
        var arrayString = [String]()
        for item in dictionary {
            if item.name == "" {
                arrayString.append("\(item.value)")
            } else {
                arrayString.append("\(item.name): \(item.value)")
            }
        }
        
        return arrayString.joined(separator: "\n")
    }
    
    private func setAttributeLineSpacingForLabel(withString string: String, andSpacing spacing: CGFloat) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: string)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = spacing
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))
        
        return attributedString
    }
    
    func instanceFromNib() -> UIView {
        return UINib(nibName: "Comment", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
    }
    
    private func getFormattMoney(withNUmber number: Float) -> String {
        return "\(number) руб."
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == 0 {
            return (children[0] as? SliderImageViewController)!.heightFrame
        } else if indexPath.row == 1 {
            return 125
        } else if indexPath.row == 2 {
            return UITableView.automaticDimension
        }
        
        switch indexPath.row {
        case 0: return (children[0] as? SliderImageViewController)!.heightFrame
        case 1: return 125
        case 5, 7: return 8
        case 6: return heightStackView + 57
        default:
            return UITableView.automaticDimension
        }
    }
    
}

