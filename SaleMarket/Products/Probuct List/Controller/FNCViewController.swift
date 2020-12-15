//
//  FNCViewController.swift
//  SaleMarket
//
//  Created by UserDev on 15.12.2020.
//

import UIKit

class FNCViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let height: CGFloat = 100 //whatever height you want to add to the existing height
        let bounds = self.navigationController?.navigationBar.bounds
        self.navigationController?.navigationBar.frame = CGRect(x: 0, y: 0, width: bounds!.width, height: bounds!.height + height)
        
    }
}
