//
//  DetailTableViewController.swift
//  SaleMarket
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
    @IBOutlet weak var showHideDescriptionButton: UIButton!
    @IBOutlet weak var showHideDescriptionButtonConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var equipmentLabel: UILabel!
    @IBOutlet weak var showHideEquipmentButton: UIButton!
    @IBOutlet weak var showHideEquipmentButtonConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var specificationLabel: UILabel!
    @IBOutlet weak var showHideSpecificationButton: UIButton!
    @IBOutlet weak var showHideSpecificationButtonConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var commentsStackView: CommentStackView!
    @IBOutlet weak var favoriteImageButton: UIButton!
    @IBOutlet weak var fovariteTextButton: UIButton!
    
    @IBOutlet weak var dopStringView: UIView!
    
    var heightStackView: CGFloat = 0
    var product: ProductModel?

    var hideDescription = true
    var hideEquipment = true
    var hideSpecification = true
    
    let showImage = UIImage(named: "show")
    let hideImage = UIImage(named: "hide")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        settingsController()
    }
    
    @IBAction func actionShowHideDescriptionButton(_ sender: UIButton) {
        hideDescription = !hideDescription
        tableView.reloadData()
    }
    
    @IBAction func actionShowHideEquipmentButton(_ sender: UIButton) {
        hideEquipment = !hideEquipment
        tableView.reloadData()
    }
    
    @IBAction func actionShowHideSpecificationButton(_ sender: UIButton) {
        hideSpecification = !hideSpecification
        tableView.reloadData()
    }
    
    private func settingsController() {
        //Настройки для ячеек
        tableView.estimatedRowHeight = 800.0
        tableView.rowHeight = UITableView.automaticDimension
        
        //настройка свайпа назад
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
        swipeRight.direction = UISwipeGestureRecognizer.Direction.right
        self.view.addGestureRecognizer(swipeRight)
        
        //настройка наблюдателя при получение кода товара
        NotificationCenter.default.addObserver(self, selector: #selector(updateUI(notification:)), name: NSNotification.Name(rawValue: "FeatchProduct"), object: nil)
    }

    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        NotificationCenter.default.post(name: NSNotification.Name("BackProductList"), object: nil)
    }
    
    @objc func updateUI(notification: Notification) {
        if let product = notification.userInfo?["product"] as? ProductModel {
            self.product = product
            self.updateUI(infoPromo: product)
        }
    }
    
    @IBAction func actionFavoriteBUtton(_ sender: UIButton) {
//        if favoriteManager.checkFovarite(withId: product!.id) {
        let favoriteCheck = CoreDataManager.shared.checkInListWBProduct(wihtURL: product!.urlWildberies)
        if favoriteCheck {
//            favoriteManager.deleteFavorite(wihtId: product!.id)
            CoreDataManager.shared.deleteFromWBProductList(wihtURL: product!.urlWildberies)
        } else {
//            favoriteManager.addFavorite(wihtId: product!.id)
            CoreDataManager.shared.saveWBProduct(withUrlProduct: product!.urlWildberies)
        }
        
        updateFavoriteButton()
    }
    
    private func updateFavoriteButton() {
        let starImage = UIImage(named: "heart")
        let starFillImage = UIImage(named: "heartfill")
        
        //let favoriteCheck = favoriteManager.checkFovarite(withId: product!.id)
        let favoriteCheck = CoreDataManager.shared.checkInListWBProduct(wihtURL: product!.urlWildberies)
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

        ratingStackView.starsRating = Int(item.rating)

        if item.price != 0 {
            dopStringView.isHidden = false
        } else {
            dopStringView.isHidden = true
        }
//        descriptionLabel.attributedText = setAttributeLineSpacingForLabel(withString: item.description, andSpacing: 4)
//        descriptionLabel.sizeToFit()
//
//        equipmentLabel.attributedText = setAttributeLineSpacingForLabel(withString: convertDictionaryToString(withDictionary: item.equipment), andSpacing: 5)
//        equipmentLabel.sizeToFit()
//
//        specificationLabel.attributedText = setAttributeLineSpacingForLabel(withString: convertDictionaryToString(withDictionary: item.specification), andSpacing: 5)
//        specificationLabel.sizeToFit()
//
//        commentsStackView.frame.size.height = 0
//        for itemComment in item.comments {
//            commentsStackView.addItem(wihtComment: itemComment)
//        }
        
//        heightStackView = commentsStackView.frame.size.height
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

    // MARK: - Height cell
    
    func returnHeightCell(showHideTag: Bool, button: UIButton, label: UILabel, constraint: NSLayoutConstraint) -> CGFloat {
        if showHideTag {
            button.setImage(showImage, for: .normal)
            button.setTitle("  ПОДРОБНЕЕ", for: .normal)
        } else {
            button.setImage(hideImage, for: .normal)
            button.setTitle("  СКРЫТЬ", for: .normal)
        }
        
        let currentTag = label.text == "" ? true : false
//        constraint.constant = currentTag ? 0 : 30
        button.isEnabled = !currentTag
        button.sizeToFit()
        
        if showHideTag {
            return currentTag ? 87 : 135
        } else {
            label.sizeToFit()
            return CGFloat(97) + label.frame.size.height
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0: return (children[0] as? SliderImageViewController)!.heightFrame
        case 1: return 125
        case 2: return returnHeightCell(showHideTag: hideDescription, button: showHideDescriptionButton, label: descriptionLabel, constraint: showHideDescriptionButtonConstraint)
        case 3: return returnHeightCell(showHideTag: hideEquipment, button: showHideEquipmentButton, label: equipmentLabel, constraint: showHideEquipmentButtonConstraint)
        case 4: return returnHeightCell(showHideTag: hideSpecification, button: showHideSpecificationButton, label: specificationLabel, constraint: showHideSpecificationButtonConstraint)
        case 5, 7: return 8
        case 6: return heightStackView + 57
        default:
            return UITableView.automaticDimension
        }
    }
}

