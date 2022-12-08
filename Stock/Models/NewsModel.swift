//
//  NewsModel.swift
//  Stock
//
//  Created by AnatoliiOstapenko on 24.11.2022.
//

import Foundation

struct NewsModel: Codable {
    let category: String
    let datetime: Double
    let headline: String
    let id: Int
    let image: String?
    let related: String
    let source: String
    let summary: String
    let url: String
}
