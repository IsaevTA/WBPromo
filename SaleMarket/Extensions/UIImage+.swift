//
//  UIImage+.swift
//  SaleMarket
//
//  Created by Timur Isaev on 16.12.2020.
//

import UIKit

extension UIImage {
    
    class func imageWithColor(color: UIColor, size: CGSize) -> UIImage {
        let rect: CGRect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        color.setFill()
        UIRectFill(rect)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }
    
    class func returnImageStar() -> UIImage {
        return UIImage(named: "heart")!
    }
    
    class func returnImageStarFill() -> UIImage {
        return UIImage(named: "heartfill")!
    }
    
    class func returnImageBasket() -> UIImage {
        return UIImage(named: "basket")!
    }
}
