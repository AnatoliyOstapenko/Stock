//
//  SearchResultsPresenter.swift
//  Stock
//
//  Created by AnatoliiOstapenko on 20.11.2022.
//

import Foundation
import UIKit

protocol SearchResultsViewProtocol: AnyObject {
    func setResults(results: [Results])
}

protocol SearchResultsViewPresenterProtocol: AnyObject {
    init(view: SearchResultsViewProtocol, results: [Results])
    func getResults()
    
}

class SearchResultsPresenter: SearchResultsViewPresenterProtocol {
    weak var view: SearchResultsViewProtocol?
    var results: [Results]
    
    required init(view: SearchResultsViewProtocol, results: [Results]) {
        self.view = view
        self.results = results
    }
    
    func getResults() {
        view?.setResults(results: self.results)
    }
    
    
}
