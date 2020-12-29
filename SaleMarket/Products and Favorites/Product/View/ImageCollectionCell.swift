//
//  ImageCollectionViewCell.swift
//  SaleMarket
//
//  Created by Timur Isaev on 02.12.2020.
//

import UIKit
import NVActivityIndicatorView

class ImageCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    var activityIndicator: NVActivityIndicatorView!
    
    func configure(with itemCell: String) {
        self.activityIndicator = createActivitiIndicator(view: self, viewCenter: self.center, widhtHeight: 50, typeActivity: .ballClipRotateMultiple, color: UIColor(red: 0.491, green: 0, blue: 0.722, alpha: 1))
        activityIndicator.startAnimating()
        
        let imageURL = URL(string: itemCell)
        
        let queue = DispatchQueue.global(qos: .userInitiated)
        queue.async { [weak self] in
            guard let url = imageURL, let imageData = try? Data(contentsOf: url) else { return }
            DispatchQueue.main.async { [unowned self] in
                self?.imageView.image = UIImage(data: imageData)
                self?.activityIndicator?.stopAnimating()
            }
        }

    }
}
