//
//  StockCustomButton.swift
//  Stock
//
//  Created by AnatoliiOstapenko on 09.12.2022.
//

import UIKit

class StockCustomButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(text: String) {
        self.init(frame: .zero)
        self.setTitle(text, for: .normal)
    }
    
    private func configure() {
        layer.backgroundColor = UIColor.secondaryLabel.cgColor
        layer.cornerRadius = 10
        titleLabel?.textAlignment = .center
        titleLabel?.textColor = .systemBackground
        titleLabel?.font = .preferredFont(forTextStyle: .headline)
        titleLabel?.adjustsFontSizeToFitWidth = true
        titleLabel?.minimumScaleFactor = 0.7
        translatesAutoresizingMaskIntoConstraints = false
    }
}
