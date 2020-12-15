//
//  ImageCollectionViewCell.swift
//  WBPromo
//
//  Created by Timur Isaev on 02.12.2020.
//

import UIKit
import NVActivityIndicatorView

class ImageCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    var activityIndicatorView: NVActivityIndicatorView! = nil
    
    func configure(with itemCell: String) {
        let viewCenter = self.center
        let frame = CGRect(x: viewCenter.x - 25, y: viewCenter.y - 25, width: 50, height: 50)
        activityIndicatorView = NVActivityIndicatorView(frame: frame, type: .ballClipRotateMultiple, color: UIColor(red: 0.491, green: 0, blue: 0.722, alpha: 1))
        self.addSubview(activityIndicatorView)
        activityIndicatorView.startAnimating()
        
        let imageURL = URL(string: itemCell)
        
        let queue = DispatchQueue.global(qos: .userInitiated)
        queue.async { [weak self] in
            guard let url = imageURL, let imageData = try? Data(contentsOf: url) else { return }
            DispatchQueue.main.async { [unowned self] in
                self?.imageView.image = UIImage(data: imageData)
                self?.activityIndicatorView?.stopAnimating()
            }
        }

    }
}
