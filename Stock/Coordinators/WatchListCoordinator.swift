//
//  Coordinator.swift
//  Stock
//
//  Created by AnatoliiOstapenko on 20.11.2022.
//

import Foundation
import UIKit
import FloatingPanel
import SafariServices

protocol CoordinatorProtocol: AnyObject {
    var childCoordinators: [CoordinatorProtocol] { get set }
    var navController:  UINavigationController { get set }
    init(navController: UINavigationController)
    func start()
}

protocol WatchListCoordinatorProtocol: CoordinatorProtocol {
    func setUpSearchResultsVC(viewController: UIViewController)
    func setStockDetailsVC(companyName: Results, viewController: UIViewController)
    func setUpFloatingPanel(viewController: UIViewController)
    func setUpSafari(url: URL, viewController: UIViewController)
}

class WatchListCoordinator: WatchListCoordinatorProtocol {
    var childCoordinators: [CoordinatorProtocol] = []
    var navController: UINavigationController
    
    required init(navController: UINavigationController) { self.navController = navController }
    
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
    
    func setStockDetailsVC(companyName: Results, viewController: UIViewController) {
        let view = StockDetailsVC()
//        view.coordinator = self
        view.title = companyName.description
        let navController = UINavigationController(rootViewController: view)
        if let vc = viewController as? WatchListVC { vc.present(navController, animated: true) }
    }
    
    func setUpFloatingPanel(viewController: UIViewController) {
        if viewController is WatchListVC {
            let panel = FloatingPanelController(delegate: viewController as? WatchListVC)
            let vc = NewsVC(type: .topStories)
            let networkManager = APICaller()
            let presenter = NewsVCPresenter(view: vc, networkManager: networkManager)
            vc.presenter = presenter
            vc.coordinator = self // why I can't create another instance in setUpSafari() ???
            
            panel.surfaceView.backgroundColor = .secondarySystemBackground
            panel.set(contentViewController: vc)
            panel.track(scrollView: vc.tableView)
            panel.addPanel(toParent: viewController as! WatchListVC)
        }
    }
    
   // MARK: - NewsVCCoordinator
   // FIXME: - Devide coordinators next time
    
    func setUpSafari(url: URL, viewController: UIViewController) {
        let safariVC = SFSafariViewController(url: url)
        safariVC.preferredControlTintColor = .label
        
        if viewController is NewsVC {
            DispatchQueue.main.async { viewController.present(safariVC, animated: true) }
        }
    }
}
