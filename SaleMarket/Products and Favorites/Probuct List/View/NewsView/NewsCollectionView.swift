//
//  NewsView.swift
//  SaleMarket
//
//  Created by Timur Isaev on 18.12.2020.
//

import UIKit

class NewsCollectionView: UIView {
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var arrayNewsString = [String]()
    let newsCollectionView = "NewsCollectionView"
    let newCollectionViewCell = "NewCollectionViewCell"
    
    init(frame: CGRect, arrayNews: [String]) {
        super.init(frame: frame)
        
        arrayNewsString = arrayNews
        UINib(nibName: newsCollectionView, bundle: nil).instantiate(withOwner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        // register cell
        let nibCell = UINib(nibName: newCollectionViewCell, bundle: nil)
        collectionView.register(nibCell, forCellWithReuseIdentifier: newCollectionViewCell)
        
        collectionView.reloadData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension NewsCollectionView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayNewsString.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: newCollectionViewCell, for: indexPath) as! NewCollectionViewCell
        
        let product = arrayNewsString[indexPath.row]
        cell.testLabel.text = product
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 130)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let product = arrayNewsString[indexPath.row]
        print("\(indexPath.row) - \(product)")
    }
}
