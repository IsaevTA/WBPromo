//
//  NewsViewCell.swift
//  SaleMarket
//
//  Created by UserDev on 18.12.2020.
//

import UIKit

class NewCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var foneView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let layer0 = CAGradientLayer()
        layer0.colors = [
          UIColor(red: 0.502, green: 0, blue: 0.629, alpha: 1).cgColor,
          UIColor(red: 0.725, green: 0, blue: 0.908, alpha: 0).cgColor
        ]
        layer0.locations = [0, 0.91]
        layer0.startPoint = CGPoint(x: 0.25, y: 0.5)
        layer0.endPoint = CGPoint(x: 0.75, y: 0.5)
        layer0.transform = CATransform3DMakeAffineTransform(CGAffineTransform(a: 0, b: -0.85, c: 0.85, d: 0, tx: 0.07, ty: 1.07))
        layer0.bounds = foneView.bounds.insetBy(dx: -0.5*foneView.bounds.size.width, dy: -0.5*foneView.bounds.size.height)
        layer0.position = foneView.center
        foneView.layer.addSublayer(layer0)
    }

    func configure(with itemCell: NewsModel) {
 
        self.nameLabel.text = itemCell.name
        self.imageView.image = UIImage(named: itemCell.imageMini)
    }
}
