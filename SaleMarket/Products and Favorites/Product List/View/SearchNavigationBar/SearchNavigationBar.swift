//
//  SearchNavigationBar.swift
//  SaleMarket
//
//  Created by Timur Isaev on 21.12.2020.
//

import UIKit

class SearchNavigationBar: UIView {
    
    enum StatusBorder {
        case notBorder
        case select
        case standart
    }
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var backToHomeButton: UIButton!
    @IBOutlet weak var resultSearchLabel: UILabel!
    
    weak var delegate: CustomNavigationBarDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        UINib(nibName: "SearchNavigationBar", bundle: nil).instantiate(withOwner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        setupSearchButton(wihtSelected: .standart)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @IBAction func actionSearchButton(_ sender: UIButton) {
        contentView.endEditing(true)
    }

    private func setupSearchButton(wihtSelected selected: StatusBorder) {
        
        var colorBorder: UIColor = .clear
        switch selected {
        case .notBorder: colorBorder = .clear
        case .select: colorBorder = UIColor(red: 0.725, green: 0, blue: 0.908, alpha: 1)
        case .standart: colorBorder = UIColor(red: 0.878, green: 0.878, blue: 0.878, alpha: 1)
        }
        
        searchTextField.layer.borderColor = colorBorder.cgColor
    }
}

extension SearchNavigationBar: UITextFieldDelegate {

    func textFieldDidBeginEditing(_ textField: UITextField) {
        setupSearchButton(wihtSelected: .select)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        setupSearchButton(wihtSelected: .standart)
        delegate?.searchNavigationBar!(searchText: textField.text ?? "")
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        setupSearchButton(wihtSelected: .standart)
        delegate?.searchNavigationBar!(searchText: textField.text ?? "")
        
        return true
    }
}
