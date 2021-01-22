//
//  HelpViewController.swift
//  SaleMarket
//
//  Created by Timur Isaev on 12.01.2021.
//

import UIKit

class HelpViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }
    
    @IBAction func actionBackButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
