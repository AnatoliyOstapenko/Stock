//
//  SearchResultsCell.swift
//  Stock
//
//  Created by AnatoliiOstapenko on 06.11.2022.
//

import UIKit

class SearchResultsCell: UITableViewCell {
    
    static let reuseID = "SearchResultsCell"

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
