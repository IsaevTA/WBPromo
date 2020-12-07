//
//  RatingStackView.swift
//  WBPromo
//
//  Created by Timur Isaev on 02.12.2020.
//

import UIKit

class RatingStackView: UIStackView {
    
    var starsRating = 0 {
        didSet {
            setStarsRating()
        }
    }
    
    let starImage = UIImage(systemName: "star")
    let starFillImage = UIImage(systemName: "star.fill")
    
    override func draw(_ rect: CGRect) {
        
        for starTag in 1...5 {
            let imageView = UIImageView(image: UIImage(named: "star"))
            imageView.tag = starTag
            imageView.tintColor = UIColor(red: 1, green: 0.914, blue: 0.204, alpha: 1)
            
            addArrangedSubview(imageView)
        }
        setStarsRating()
    }
    
    func setStarsRating() {
        let stackSubViews = self.subviews.filter{$0 is UIImageView}
        for subView in stackSubViews {
            if let imageView = subView as? UIImageView{
                if imageView.tag > starsRating {
                    imageView.image = starImage
                } else {
                    imageView.image = starFillImage
                }
            }
        }
    }
}
