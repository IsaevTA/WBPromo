//
//  DetailPromoViewController.swift
//  WBPromo
//
//  Created by Timur Isaev on 30.11.2020.
//

import UIKit

class DetailPromoViewController: UIViewController {

    var promoWithListRpomo: PromoListModel?
    var currentPromo: InfoPromoModel?
    var imageNameArray = [String]()
    
    @IBOutlet weak var nameLebel: UILabel!
    @IBOutlet weak var sliderCollectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        featchData()
    }
    
    private func featchData() {
        guard let promo = promoWithListRpomo else { return }
        
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
        nameLebel.text = item.name
        
        pageControl.numberOfPages = imageNameArray.count
        pageControl.currentPage = 0
    }
}

extension DetailPromoViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageNameArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as! ImageCollectionCell
        let promo = imageNameArray[indexPath.row]
        cell.configure(with: promo)
        return cell
    }
    
//    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//        for cell in sliderCollectionView.visibleCells {
//            if let indexPath = sliderCollectionView.indexPath(for: cell) {
//                pageControl.currentPage = indexPath.row
//            }
//        }
//    }
    
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

extension DetailPromoViewController: UICollectionViewDelegateFlowLayout {
    
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
