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
    @IBOutlet weak var testView: UIView!

    var currentNewsTest: NewsModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        startTest()
        
        NotificationCenter.default.addObserver(self, selector: #selector(backController), name: NSNotification.Name(rawValue: "BackHome"), object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tabBarController?.tabBar.isHidden = true
    }
    
    @objc private func backController() {
        navigationController?.popViewController(animated: true)
    }
    
    private func startTest() {
    
        let rect = CGRect(x: 0, y: 0, width: testView.frame.size.width, height: testView.frame.size.height)
        guard let currentTest = TestClass.shared.loadJson(testId: currentNewsTest?.testId) else { return }
        let view = TestView(frame: rect, currentTest: currentTest)
        view.translatesAutoresizingMaskIntoConstraints = false
        testView.addSubview(view)

        view.topAnchor.constraint(equalTo: testView.topAnchor).isActive = true
        view.leadingAnchor.constraint(equalTo: testView.leadingAnchor).isActive = true
        view.trailingAnchor.constraint(equalTo: testView.trailingAnchor).isActive = true
        view.bottomAnchor.constraint(equalTo: testView.bottomAnchor).isActive = true
        
        NotificationCenter.default.addObserver(self, selector: #selector(showResult(notification:)), name: NSNotification.Name(rawValue: "FinishTest"), object: nil)
    }
    
    @objc private func showResult(notification: Notification) {
        testView.removeAllSubView()
        
        guard let result = notification.userInfo?["result"] as? Int else { return }
        guard let currentTest = TestClass.shared.loadJson(testId: currentNewsTest?.testId) else { return }
        
        let rect = CGRect(x: 0, y: 0, width: testView.frame.size.width, height: testView.frame.size.height)
        let view = ResultTestView(frame: rect, test: currentTest, result: result)
        view.translatesAutoresizingMaskIntoConstraints = false
        testView.addSubview(view)

        view.topAnchor.constraint(equalTo: testView.topAnchor).isActive = true
        view.leadingAnchor.constraint(equalTo: testView.leadingAnchor).isActive = true
        view.trailingAnchor.constraint(equalTo: testView.trailingAnchor).isActive = true
        view.bottomAnchor.constraint(equalTo: testView.bottomAnchor).isActive = true
    }
    
    private func setupUI() {
        //настройка свайпа назад
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
        swipeRight.direction = UISwipeGestureRecognizer.Direction.right
        self.view.addGestureRecognizer(swipeRight)
        
        titleLabel.text = currentNewsTest?.name
        imageView.image = UIImage(named: currentNewsTest!.image)
    }
    
    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        backController()
    }
    
    @IBAction func actionBackButton(_ sender: UIButton) {
        backController()
    }
}
