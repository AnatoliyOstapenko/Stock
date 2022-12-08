//
//  NewsCellModel.swift
//  Stock
//
//  Created by AnatoliiOstapenko on 26.11.2022.
//

import Foundation

struct NewsCellModel {
    let source: String
    let headline: String
    let dateString: String
    let imageURL: URL?
    
    init(model: NewsModel) {
        self.source = model.source
        self.headline = model.headline
        self.dateString = model.datetime.timeIntervalToString
        self.imageURL = URL(string: model.url)
    }
}
