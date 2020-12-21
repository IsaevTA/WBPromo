//
//  CommentStackView.swift
//  SaleMarket
//
//  Created by Timur Isaev on 06.12.2020.
//

import UIKit

class CommentStackView: UIStackView {
    
    func addItem(wihtComment comment: Comments) {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "CommentView", bundle: bundle)
        let commentView = CommentView()
        let view = nib.instantiate(withOwner: commentView, options: nil).first as! UIView
        commentView.configurationView(wihtComment: comment, andView: self)
        commentView.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height)
        commentView.addSubview(view)
        commentView.translatesAutoresizingMaskIntoConstraints = false
        
        addArrangedSubview(commentView)
        
        commentView.heightAnchor.constraint(equalToConstant: view.frame.size.height).isActive = true
        commentView.widthAnchor.constraint(equalToConstant: view.frame.size.width).isActive = true
        
        self.frame.size.height += view.frame.size.height + self.spacing
    }

}
