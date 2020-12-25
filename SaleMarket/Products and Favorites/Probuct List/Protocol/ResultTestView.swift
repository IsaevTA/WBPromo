//
//  ResulеTestView.swift
//  SaleMarket
//
//  Created by UserDev on 25.12.2020.
//

import UIKit

class ResultTestView: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var resultImage: UIImageView!
    @IBOutlet weak var resultDescriptionTextView: UITextView!
    
    let nameXib = "ResultTestView"
    
    var currentTest: TestModel
    var resultTest: Int
    
    init(frame: CGRect, test: TestModel, result: Int) {
        self.currentTest = test
        self.resultTest = result
        
        super.init(frame: frame)
        
        UINib(nibName: nameXib, bundle: nil).instantiate(withOwner: self, options: nil)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(contentView)

        contentView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        setupUI()
    }
    
    private func setupUI() {
        let number = Int.random(in: 1...currentTest.result.count)
        let result = currentTest.result[number - 1]
        resultLabel.text = result.name
        resultImage.image = UIImage(named: result.image)
        resultDescriptionTextView.text = result.text
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBAction func actionBackHomeButton(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name("BackHome"), object: nil)
    }
}
