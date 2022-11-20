//
//  WatchListVC.swift
//  Stock
//
//  Created by AnatoliiOstapenko on 05.11.2022.
//

import UIKit

class WatchListVC: UIViewController {
    
    // MARK: - Public proporties
    var coordinator: CoordinatorProtocol?
    var presenter: WatchListPresenterProtocol?
    
    // MARK: - Private proporties
    private var timer: Timer?
    private var results: [Results] = []
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setUpTitleView()
        coordinator?.setUpSearchResultsVC(viewController: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // MARK: - Private methods
    
    private func setUpTitleView() {
        let titleView = UIView(frame: CGRect(x: 0, y: 0, width: view.width, height: navigationController?.navigationBar.height ?? 100))
        let label = UILabel(frame: CGRect(x: 10, y: 0, width: titleView.width - 20, height: titleView.height))
        label.text = Constants.stocks
        label.font = .systemFont(ofSize: 36, weight: .medium)
        titleView.addSubview(label)
        navigationItem.titleView = titleView
    }
}

extension WatchListVC: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {       
        // guard let resultVC = searchController.searchResultsController as? SearchResultsVC else { return }
        timer?.invalidate() // reset timer
        // Cut douwn of requests to the external API
        timer = Timer.scheduledTimer(withTimeInterval: 0.4, repeats: false, block: { _ in
            self.presenter?.getStocks(searchController: searchController)
        })
    }
}

extension WatchListVC: SearchResultsVCDelegate {
    func didSelected(_ companyName: Results) {
        // Present stock details for given selection
        navigationItem.searchController?.searchBar.resignFirstResponder() // hide keyboard when you come back
        self.coordinator?.setStockDetailsVC(companyName: companyName, root: self)  
    }
}

extension WatchListVC: WatchListViewProtocol {}
