//
//  CustomErrors.swift
//  Stock
//
//  Created by AnatoliiOstapenko on 05.11.2022.
//

import Foundation

enum CustomErrors: String, Error {
    case urlIsNil = "Unfortunately, there is no possible to follow the url link, please choose other news"
    case urlRequestIsNil = "Request fails, url is not found"
    case urlSearchIsNil = "Search fails, url is not found"
    case urlQueryIsNotAllowed = "URL query is not allowed"
    case taskFail = "Request fails, check up your internet connection"
    case decodeFail = "Request fails, JSON can't decode data"
}
