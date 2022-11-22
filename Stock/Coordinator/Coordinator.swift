//
//  Coordinator.swift
//  Stock
//
//  Created by AnatoliiOstapenko on 20.11.2022.
//

import Foundation
import UIKit
import FloatingPanel

protocol CoordinatorProtocol {
    var navController: UINavigationController { get set }
    func start()
    func setUpSearchResultsVC(viewController: UIViewController)
    
    func setUpFloatingPanel(viewController: UIViewController)
}

protocol StockDetailsCoordinatorProtocol {
    var navController: UINavigationController { get set }
    func setStockDetailsVC(companyName: Results, viewController: UIViewController)
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
            resultVC.delegate = viewController as? WatchListVC // it's for SearchResultsVCDelegate
            let searchVC = UISearchController(searchResultsController: resultVC)
            searchVC.searchResultsUpdater = viewController as? WatchListVC
            viewController.navigationItem.searchController = searchVC
        }
    }
    
    
    
    func setUpFloatingPanel(viewController: UIViewController) {
        if viewController is WatchListVC {
            let panel = FloatingPanelController(delegate: viewController as? WatchListVC)
            let vc = NewsVC(type: .topStories)
            panel.surfaceView.backgroundColor = .secondarySystemBackground
            panel.set(contentViewController: vc)
            panel.track(scrollView: vc.tableView)
            panel.addPanel(toParent: viewController as! WatchListVC)
        }
        
    }
}

class StockDetailsVC: StockDetailsCoordinatorProtocol {
    var navController: UINavigationController
    init(navController: UINavigationController) { self.navController = navController }
    
    func setStockDetailsVC(companyName: Results, viewController: UIViewController) {
        let view = StockDetailsVC()
        view.coordinator = self
        view.title = companyName.description
        let navController = UINavigationController(rootViewController: view)
        if let vc = viewController as? WatchListVC { vc.present(navController, animated: true) }
    }
    
    
}
