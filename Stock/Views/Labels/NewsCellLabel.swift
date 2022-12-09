//
//  NewsCellLabel.swift
//  Stock
//
//  Created by AnatoliiOstapenko on 25.11.2022.
//

import UIKit

class NewsCellLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(ofSize: CGFloat, weight: UIFont.Weight, textColor: UIColor) {
        self.init(frame: .zero)
        font = .systemFont(ofSize: ofSize, weight: weight)
        self.textColor = textColor
    }
    
    private func configure() {
        numberOfLines = 0
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.7
    }

}
