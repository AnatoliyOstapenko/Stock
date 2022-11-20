//
//  SearchResponseModel.swift
//  Stock
//
//  Created by AnatoliiOstapenko on 16.11.2022.
//

import Foundation

struct SearchResponseModel: Codable {
    let count: Int
    let results: [Results]
    
    enum CodingKeys: String, CodingKey {
        case count
        case results = "result"
    }
}

struct Results: Codable {
    let description: String
    let displaySymbol: String
    let symbol: String
    let type: String
}


