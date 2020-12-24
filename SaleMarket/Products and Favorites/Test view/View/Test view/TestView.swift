//
//  TestView.swift
//  SaleMarket
//
//  Created by Timur Isaev on 24.12.2020.
//

import UIKit

class TestView: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nameTestLabel: UILabel!
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    
    var currentTest: TestModel
    var currentQuestion: TestQuestion
    var currentNumber = 0
    
    let nameXib = "TestView"
    let nameCellXib = "TestTableViewCell"
    
    init(frame: CGRect, currentTest test: TestModel) {
        
        self.currentTest = test
        self.currentQuestion = self.currentTest.test[self.currentNumber]
        super.init(frame: frame)
        
        UINib(nibName: nameXib, bundle: nil).instantiate(withOwner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        
        // register cell
        let nibCell = UINib(nibName: nameCellXib, bundle: nil)
        tableView.register(nibCell, forCellReuseIdentifier: nameCellXib)
        
        setupUI()
    }
    
    private func setupUI() {
        currentQuestion = currentTest.test[currentNumber]
        nameTestLabel.text = currentTest.name
        questionLabel.text = currentQuestion.question
        numberLabel.text = "\(currentNumber + 1)/\(String(describing: currentTest.test.count))"
        tableView.reloadData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBAction func actionNextButton(_ sender: UIButton) {
        currentNumber += 1
        
        if currentNumber >= currentTest.test.count {
            nextButton.setTitle("УЗНАТЬ РЕЗУЛЬТАТ", for: .normal)

            return
        }
        
        setupUI()
        
    }
}

extension TestView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentQuestion.answers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: nameCellXib, for: indexPath) as! TestTableViewCell
        
        let item = currentQuestion.answers[indexPath.row]
        cell.label.text = item
        return cell
    }
    
    
}
