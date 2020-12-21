//
//  CommentsView.swift
//  SaleMarket
//
//  Created by Timur Isaev on 06.12.2020.
//

import UIKit

class CommentView: UIView {
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var nameUserLabel: UILabel!
    @IBOutlet weak var cityUserLabel: UILabel!
    @IBOutlet weak var ratingStackView: RatingStackView!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var commentImage: UIImageView!
    
    @IBOutlet var view: UIView!
    
    func configurationView(wihtComment comment: Comments, andView rootView: UIView){

        view.frame.size.width = rootView.frame.size.width
        
        nameUserLabel.text = comment.name
        cityUserLabel.text = comment.city
        ratingStackView.starsRating = comment.rating

        commentLabel.text = comment.body
        commentLabel.sizeToFit()
        commentLabel.heightAnchor.constraint(equalToConstant: commentLabel.frame.size.height).isActive = true
                
        getImage(withURLString: comment.userAvatar, andImageView: avatarImage)
        
        var heightImage: CGFloat = 0.0
        if comment.image != "" {
            getImage(withURLString: comment.image, andImageView: commentImage)
            heightImage = 180.0
        } else {
            commentImage.isHidden = true
        }
        
        let heightRootView = 120.0 + commentLabel.frame.size.height + 10.0 + heightImage
        view.frame.size.height = heightRootView
    }
    
    private func getImage(withURLString urlString: String, andImageView imageView: UIImageView) {
        let imageURL = URL(string: urlString)
        let queue = DispatchQueue.global(qos: .userInitiated)
        queue.async {
            guard let url = imageURL, let imageData = try? Data(contentsOf: url) else { return }
            DispatchQueue.main.async {
                imageView.image = UIImage(data: imageData)
            }
        }
    }
    
}
