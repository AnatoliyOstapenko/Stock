//
//  WatchListVC.swift
//  Stock
//
//  Created by AnatoliiOstapenko on 05.11.2022.
//

import UIKit

class WatchListVC: UIViewController {
    
    // MARK: - Private proporties
    
    private var timer: Timer?
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setUpSearchController()
        setUpTitleView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    // MARK: - Private methods
    
    private func setUpTitleView() {
        let titleView = UIView(frame: CGRect(x: 0, y: 0, width: view.width, height: navigationController?.navigationBar.height ?? 100))
 
        let label = UILabel(frame: CGRect(x: 10, y: 0, width: titleView.width - 20, height: titleView.height))
        label.text = "Stocks"
        label.font = .systemFont(ofSize: 36, weight: .medium)
        titleView.addSubview(label)
        navigationItem.titleView = titleView
    }
    
    private func setUpSearchController() {
        let resultVC = SearchResultsVC()
        resultVC.delegate = self
        let searchVC = UISearchController(searchResultsController: resultVC)
        searchVC.searchResultsUpdater = self
        navigationItem.searchController = searchVC
    }
}

extension WatchListVC: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let query = searchController.searchBar.text, !query.trimmingCharacters(in: .whitespaces).isEmpty, let resultVC = searchController.searchResultsController as? SearchResultsVC else { return }
        let concatenation = query.compactMap {String($0)}.filter{$0 != " "}.joined()
        timer?.invalidate() // reset timer
        // Cut douwn of requests to the external API
        timer = Timer.scheduledTimer(withTimeInterval: 0.4, repeats: false, block: { _ in
            APICaller.shared.search(query: concatenation) { data in
                switch data {
                case .success(let results):
                    DispatchQueue.main.async { resultVC.update(results.results) }
                case .failure(let error):
                    print("Error: \(error.rawValue)")
                    DispatchQueue.main.async { resultVC.update([]) }
                }
            }
        })
    }
}

extension WatchListVC: SearchResultsVCDelegate {
    func didSelected(_ companyName: Results) {
        // Present stock details for given selection
        print(companyName.description)
    }
    
    
}
