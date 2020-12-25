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
    var currentNumber: Int = 0
    
    var currentAnswer: Int = 0
    var resultTest: Int = 0
    
    let nameXib = "TestView"
    let nameCellXib = "TestTableViewCell"
    
    var radioButtonController = RadioButtonsController()
    
    init(frame: CGRect, currentTest test: TestModel) {
        
        self.currentTest = test
        self.currentQuestion = self.currentTest.test[self.currentNumber]
        super.init(frame: frame)
        
        UINib(nibName: nameXib, bundle: nil).instantiate(withOwner: self, options: nil)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(contentView)

        contentView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        // register cell
        let nibCell = UINib(nibName: nameCellXib, bundle: nil)
        tableView.register(nibCell, forCellReuseIdentifier: nameCellXib)
        
        setupUIAndTesting()
    }
    
    private func setupUIAndTesting() {
        resultTest += currentAnswer
        currentAnswer = 0
        
        radioButtonController.removeAllSelections()
        radioButtonController.removeAllButton()
        
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
        
        currentAnswer = radioButtonController.selectedButton()?.tag ?? 0
        if currentAnswer == 0 { return }
        if currentNumber == currentTest.test.count - 1 {
            resultTest += currentAnswer
            NotificationCenter.default.post(name: NSNotification.Name("FinishTest"), object: nil, userInfo: ["result": resultTest])
            return
        }

        currentNumber += 1

        if currentNumber == currentTest.test.count - 1 {
            nextButton.setTitle("УЗНАТЬ РЕЗУЛЬТАТ", for: .normal)
        }

        setupUIAndTesting()
    }
}

extension TestView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentQuestion.answers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: nameCellXib, for: indexPath) as! TestTableViewCell
        
        let item = currentQuestion.answers[indexPath.row]
        cell.button.tag = indexPath.row + 1
        radioButtonController.addButton(cell.button)
        cell.label.text = item
        return cell
    }
}
