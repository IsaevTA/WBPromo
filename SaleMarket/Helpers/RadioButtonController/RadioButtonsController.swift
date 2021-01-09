//
//  RadioButtonsController.swift
//  SaleMarket
//
//  Created by Timur Isaev on 24.12.2020.
//

import Foundation
import UIKit

@objc protocol RadioButtonControllerDelegate {
    @objc func didSelectButton(selectedButton: UIButton?)
}

class RadioButtonsController : NSObject {
    fileprivate var buttonsArray = [UIButton]()
    weak var delegate : RadioButtonControllerDelegate? = nil

    var shouldLetDeSelect = false

    init(buttons: UIButton...) {
        super.init()
        for aButton in buttons {
            aButton.addTarget(self, action: #selector(RadioButtonsController.pressed(_:)), for: .touchUpInside)
        }
        self.buttonsArray = buttons
    }

    func addButton(_ aButton: UIButton) {
        buttonsArray.append(aButton)
        aButton.addTarget(self, action: #selector(RadioButtonsController.pressed(_:)), for: .touchUpInside)
    }

    func removeButton(_ aButton: UIButton) {
        var iteratingButton: UIButton? = nil
        
        if(buttonsArray.contains(aButton)) {
            iteratingButton = aButton
        }
        
        if(iteratingButton != nil) {
            buttonsArray.remove(at: buttonsArray.firstIndex(of: iteratingButton!)!)
            iteratingButton!.removeTarget(self, action: #selector(RadioButtonsController.pressed(_:)), for: .touchUpInside)
            iteratingButton!.isSelected = false
        }
    }

    func removeAllButton() {
        buttonsArray.removeAll()
    }
    
    func removeAllSelections() {
        for button in buttonsArray {
            button.isSelected = false
        }
    }
    
    func setButtonsArray(_ aButtonsArray: [UIButton]) {
        for aButton in aButtonsArray {
            aButton.addTarget(self, action: #selector(RadioButtonsController.pressed(_:)), for: .touchUpInside)
        }
        buttonsArray = aButtonsArray
    }

    @objc func pressed(_ sender: UIButton) {
        var currentSelectedButton: UIButton? = nil
        if (sender.isSelected) {
            if shouldLetDeSelect {
                sender.isSelected = false
                currentSelectedButton = nil
            }
        } else {
            for aButton in buttonsArray {
                aButton.isSelected = false
            }
            sender.isSelected = true
            currentSelectedButton = sender
        }
        delegate?.didSelectButton(selectedButton: currentSelectedButton)
    }

    func selectedButton() -> UIButton? {
        guard let index = buttonsArray.firstIndex(where: { button in button.isSelected }) else { return nil }
        
        return buttonsArray[index]
    }
}
