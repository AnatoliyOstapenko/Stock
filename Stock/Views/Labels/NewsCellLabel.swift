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
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(ofSize: CGFloat, weight: UIFont.Weight) {
        self.init(frame: .zero)
        font = .systemFont(ofSize: ofSize, weight: weight)
    }
    
    private func configure() {
        
    }

}
