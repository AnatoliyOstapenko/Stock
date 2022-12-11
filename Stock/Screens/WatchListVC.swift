//
//  WatchListVC.swift
//  Stock
//
//  Created by AnatoliiOstapenko on 05.11.2022.
//

import UIKit
import FloatingPanel

class WatchListVC: UIViewController {
    
    // MARK: - Public proporties
    weak var coordinator: WatchListCoordinatorProtocol?
    var presenter: WatchListPresenterProtocol?
    
    // MARK: - Private proporties
    private var timer: Timer?
    private var results: [Results] = []
    private var watchListMap: [String: [String]] = [:]
    private var viewModels: [String] = []
    
    
    let watchListTableView = UITableView()
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        coordinator?.setUpSearchResultsVC(viewController: self)
        coordinator?.setUpFloatingPanel(viewController: self)
        setUpTitleView()
        setUpTableView()
        watchListData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }
    
    // MARK: - Layout
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        watchListTableView.frame = view.bounds
    }
    
    // MARK: - Private methods
    
    private func watchListData() {
        let symbols = PersistenceManager.shared.watchList
        
//        symbols.forEach{ watchListMap[$0] = ["some string"] } // test this line after debuging
        
        for symbol in symbols {
            watchListMap[symbol] = ["some string"]
        }
        
        watchListTableView.reloadData()
    }
    
    private func setUpTitleView() {
        let titleView = UIView(frame: CGRect(x: 0, y: 0, width: view.width, height: navigationController?.navigationBar.height ?? 100))
        let label = UILabel(frame: CGRect(x: 10, y: 0, width: titleView.width - 20, height: titleView.height))
        label.text = Constants.stocks
        label.font = .systemFont(ofSize: 36, weight: .medium)
        titleView.addSubview(label)
        navigationItem.titleView = titleView
    }
    
    private func setUpTableView() {
        view.addSubview(watchListTableView)
        watchListTableView.backgroundColor = .clear

        watchListTableView.dataSource = self
        watchListTableView.delegate = self
    }
}

extension WatchListVC: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        timer?.invalidate() // reset timer
        // Cut douwn of requests to the external API
        timer = Timer.scheduledTimer(withTimeInterval: 0.4, repeats: false, block: { _ in
            self.presenter?.getStocks(searchController: searchController)
        })
    }
}

extension WatchListVC: SearchResultsVCDelegate {
    func didSelected(_ companyName: Results) {
        navigationItem.searchController?.searchBar.resignFirstResponder() // hide keyboard when you come back
        self.coordinator?.setStockDetailsVC(companyName: companyName, viewController: self)
    }
}

extension WatchListVC: WatchListViewProtocol {}

extension WatchListVC: FloatingPanelControllerDelegate {
    func floatingPanelDidChangeState(_ fpc: FloatingPanelController) {
        navigationItem.titleView?.isHidden = fpc.state == .full
        
    }
}

// MARK: - TableViewDataSource & TableViewDelegate

extension WatchListVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return watchListMap.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    
}

extension WatchListVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // do further
    }
}
