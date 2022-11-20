//
//  WatchListPresenter.swift
//  Stock
//
//  Created by AnatoliiOstapenko on 20.11.2022.
//

import Foundation
import UIKit

protocol WatchListViewProtocol: AnyObject {} // FIXME: - Never used

protocol WatchListPresenterProtocol: AnyObject {
    init(view: WatchListViewProtocol, networkManager: APICallerProtocol)
    func getStocks(searchController: UISearchController)
}

class WatchListPresenter: WatchListPresenterProtocol {
    weak var view: WatchListViewProtocol?
    private let networkManager: APICallerProtocol
    
    required init(view: WatchListViewProtocol, networkManager: APICallerProtocol) {
        self.view = view
        self.networkManager = networkManager
    }
    
    func getStocks(searchController: UISearchController) {
        guard let query = searchController.searchBar.text, !query.trimmingCharacters(in: .whitespaces).isEmpty,
        let resultVC = searchController.searchResultsController as? SearchResultsVC else { return }
        let concatenation = query.compactMap {String($0)}.filter{$0 != " "}.joined()
        
        networkManager.search(query: concatenation) { results in
            switch results {
            case .success(let success):
                DispatchQueue.main.async { resultVC.update(success.results) }
            case .failure(let failure):
                print("Debug error: \(failure.rawValue)")
                DispatchQueue.main.async { resultVC.update([]) }
            }
        }
    }
}
