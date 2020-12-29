//
//  ActivityIndicator.swift
//  SaleMarket
//
//  Created by Timur Isaev on 16.12.2020.
//

import UIKit
import NVActivityIndicatorView

func createActivitiIndicator(view: UIView, viewCenter: CGPoint, widhtHeight: CGFloat, typeActivity: NVActivityIndicatorType, color: UIColor) -> NVActivityIndicatorView {
    
    let frame = CGRect(x: viewCenter.x - (widhtHeight / 2), y: viewCenter.y - (widhtHeight / 2), width: widhtHeight, height: widhtHeight)
    let activityIndicatorView = NVActivityIndicatorView(frame: frame, type: typeActivity, color: color) //UIColor(red: 0.491, green: 0, blue: 0.722, alpha: 1)
    view.addSubview(activityIndicatorView)
    
    return activityIndicatorView
}
