//
//  CustomErrors.swift
//  Stock
//
//  Created by AnatoliiOstapenko on 05.11.2022.
//

import Foundation

enum CustomErrors: String, Error {
    case urlNil = "Request fails, url is not found"
    case taskFail = "Request fails, dataTask is not working properly"
    case decodeFail = "Request fails, JSON can't decode data"
}
