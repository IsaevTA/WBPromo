//
//  TestViewController.swift
//  SaleMarket
//
//  Created by Timur Isaev on 24.12.2020.
//

import UIKit

class TestViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameTestLabel: UILabel!
    
    @IBOutlet weak var answerOne: UIButton!
    @IBOutlet weak var answerTwo: UIButton!
    @IBOutlet weak var answerThree: UIButton!
    @IBOutlet weak var answerFour: UIButton!
    @IBOutlet weak var answerFive: UIButton!
    
    var currentNewsTest: NewsModel?
    var radioButtonController: RadioButtonsController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        radioButtonController = RadioButtonsController(buttons: answerOne, answerTwo, answerThree, answerFour, answerFive)
        radioButtonController!.delegate = self
        radioButtonController!.shouldLetDeSelect = true
        
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tabBarController?.tabBar.isHidden = true
    }
    
    private func setupUI() {
        //настройка свайпа назад
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
        swipeRight.direction = UISwipeGestureRecognizer.Direction.right
        self.view.addGestureRecognizer(swipeRight)
        
        titleLabel.text = currentNewsTest?.name
        imageView.image = UIImage(named: currentNewsTest!.image)
        nameTestLabel.text = currentNewsTest?.name
    }
    
    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        backController()
    }
    
    @IBAction func actionBackButton(_ sender: UIButton) {
        backController()
    }
    
    private func backController() {
        navigationController?.popViewController(animated: true)
    }
}

extension TestViewController: RadioButtonControllerDelegate {
    func didSelectButton(selectedButton: UIButton?)
    {
        print(" \(selectedButton?.tag)" )
    }
}

