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
    
    private let defaults: UserDefaults = .standard
    private var hasOnBoarded: Bool { return false }
    
    
    // MARK: - Public properties and methods
    
    public var watchList: [String] { return [] }
    
    public func addToWathcList() {}
    
    public func removeFromWatchList() {}
    
   
}
