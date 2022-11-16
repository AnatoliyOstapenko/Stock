//
//  CustomErrors.swift
//  Stock
//
//  Created by AnatoliiOstapenko on 05.11.2022.
//

import Foundation

enum CustomErrors: String, Error {
    case urlRequestIsNil = "Request fails, url is not found"
    case urlSearchIsNil = "Search fails, url is not found"
    case urlQueryIsNotAllowed = "URL query is not allowed"
    case taskFail = "Request fails, dataTask is not working properly"
    case decodeFail = "Request fails, JSON can't decode data"
}
