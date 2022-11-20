//
//  Coordinator.swift
//  Stock
//
//  Created by AnatoliiOstapenko on 20.11.2022.
//

import Foundation
import UIKit

protocol CoordinatorProtocol {
    var navController: UINavigationController { get set }
    func start()
    func setUpSearchResultsVC(viewController: UIViewController)
    func setStockDetailsVC(companyName: Results, root: UIViewController)
}

class Coordinator: CoordinatorProtocol {
    var navController: UINavigationController
    init(navController: UINavigationController) { self.navController = navController }
    
    func start() {
        let view = WatchListVC()
        let networkManager = APICaller()
        let presenter = WatchListPresenter(view: view, networkManager: networkManager)
        view.presenter = presenter
        view.coordinator = self
        navController.pushViewController(view, animated: true)
    }
    
    func setUpSearchResultsVC(viewController: UIViewController) {
        let resultVC = SearchResultsVC()
        resultVC.coordinator = self
        
        if viewController is WatchListVC {
            resultVC.delegate = viewController as? WatchListVC
            let searchVC = UISearchController(searchResultsController: resultVC)
            searchVC.searchResultsUpdater = viewController as? WatchListVC
            viewController.navigationItem.searchController = searchVC
        }
    }
    
    func setStockDetailsVC(companyName: Results, root: UIViewController) {
        let view = StockDetailsVC()
        view.coordinator = self
        view.title = companyName.description
        let navController = UINavigationController(rootViewController: view)
        if let vc = root as? WatchListVC { vc.present(navController, animated: true) }
    }    
}
