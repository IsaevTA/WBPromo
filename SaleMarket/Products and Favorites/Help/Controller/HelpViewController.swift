//
//  HelpViewController.swift
//  SaleMarket
//
//  Created by UserDev on 12.01.2021.
//

import UIKit

class HelpViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        scrollView.contentSize = CGSize(width: self.view.bounds.size.width, height: self.view.bounds.size.height + 200)
        
        tabBarController?.tabBar.isHidden = true
    }
    
    @IBAction func actionBackButton(_ sender: UIButton) {
//        self.dismiss(animated: true, completion: nil)
        self.navigationController?.popViewController(animated: true)
//        dismiss(animated: true, completion: nil)
//        navigationController?.popViewController(animated: true)
    }
    
}
