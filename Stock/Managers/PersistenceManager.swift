//
//  PersistenceManager.swift
//  Stock
//
//  Created by AnatoliiOstapenko on 05.11.2022.
//

import Foundation

final class PersistenceManager {
    
    static let shared = PersistenceManager()
    private init() {}
    
    // MARK: - Private properties
    
    private let userDefaults: UserDefaults = .standard
    
    private var hasOnBoarded: Bool {
        return userDefaults.bool(forKey: "hasOnBoarded")
    }
    
    private func setUpDefaults() {
        let stocks: [String: String] = [
            "AAPL": "Apple Inc. Common Stock",
            "MSFT": "Microsoft Corporation",
            "GOOG": "Alphabet Inc. Class C Capital Stock",
            "AMZN": "Amazon.com",
            "DIS" : "The Walt Disney Company",
            "INTC": "Intel Corporation"
        ]
        
        let symbols = stocks.keys.map {$0}
        userDefaults.set(symbols, forKey: "watchList")
        
        for (symbols, name) in stocks {
            userDefaults.set(name, forKey: symbols)
        }
    }
    
    
    // MARK: - Public properties and methods
    
    public var watchList: [String] {
        if !hasOnBoarded {
            userDefaults.setValue(true, forKey: "hasOnBoarded")
            setUpDefaults()
        }
        return userDefaults.stringArray(forKey: "watchList") ?? []
    }
    
    public func addToWathcList() {}
    
    public func removeFromWatchList() {}
    
   
}
