//
//  SliderImageView.swift
//  SaleMarket
//
//  Created by Timur Isaev on 04.12.2020.
//

import UIKit

class SliderImageViewController: UIViewController {

    var currentPromo: ProductModel?
    var imageNameArray = [String]()
    var heightFrame: CGFloat = 0.0
    
    @IBOutlet weak var sliderCollectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateUI(notification:)), name: NSNotification.Name(rawValue: "FeatchPromo"), object: nil)
    }

    @objc func updateUI(notification: Notification) {
        if let promo = notification.userInfo?["promo"] as? ProductModel {
            imageNameArray = promo.images
            
            pageControl.numberOfPages = imageNameArray.count
            pageControl.currentPage = 0
            
            sliderCollectionView.reloadData()
            heightFrame = self.view.frame.size.height
        }
    }
}

extension SliderImageViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageNameArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as! ImageCollectionCell
        let promo = imageNameArray[indexPath.row]
        cell.configure(with: promo)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if collectionView == sliderCollectionView {
            if pageControl.currentPage == indexPath.row {
                guard let visible = sliderCollectionView.visibleCells.first else { return }
                guard let index = sliderCollectionView.indexPath(for: visible)?.row else { return }
                pageControl.currentPage = index
            }

        }
    }
}

extension SliderImageViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = sliderCollectionView.frame.size
        return CGSize(width: size.width, height: size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
}
