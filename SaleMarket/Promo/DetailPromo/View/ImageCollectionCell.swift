//
//  ImageCollectionViewCell.swift
//  WBPromo
//
//  Created by Timur Isaev on 02.12.2020.
//

import UIKit

class ImageCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    func configure(with itemCell: String) {
        
        let imageURL = URL(string: itemCell)
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        
        let queue = DispatchQueue.global(qos: .userInitiated)
        queue.async { [weak self] in
            guard let url = imageURL, let imageData = try? Data(contentsOf: url) else { return }
            DispatchQueue.main.async {
                self?.imageView.image = UIImage(data: imageData)
                self?.activityIndicator.isHidden = true
                self?.activityIndicator.stopAnimating()
            }
        }

    }
}
