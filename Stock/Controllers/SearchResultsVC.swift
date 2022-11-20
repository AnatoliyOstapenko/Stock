//
//  SearchResultsVC.swift
//  Stock
//
//  Created by AnatoliiOstapenko on 05.11.2022.
//

import UIKit

protocol SearchResultsVCDelegate: AnyObject {
    func didSelected(_ companyName: Results)
}

class SearchResultsVC: UIViewController {
    
    weak var delegate: SearchResultsVCDelegate?
    var results: [Results] = []
    var coordinator: CoordinatorProtocol?
    var presenter: SearchResultsViewPresenterProtocol?
    
    private let tableView: UITableView  = {
        let tableView = UITableView()
        tableView.register(SearchResultsCell.self, forCellReuseIdentifier: SearchResultsCell.reuseID)
        tableView.isHidden = true
        return tableView
    }()
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        setUpTablewView()
        presenter?.getResults()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    // MARK: - Public methods
    
    public func update(_ results: [Results]) {
        self.results = results
        tableView.isHidden = results.isEmpty
        tableView.reloadData()
    }
    
    // MARK: - Private methods
    
    private func updateUI() {
        view.backgroundColor = .systemBackground
        title = "SearchResultsVC"
    }
    
    private func setUpTablewView() {
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
    }
}

// MARK: - TableView DataSource

extension SearchResultsVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchResultsCell.reuseID, for: indexPath) as! SearchResultsCell
        cell.updateCellUI(results: results[indexPath.row], number: indexPath.row)
        return cell
    }
}

// MARK: - TableView Delegate

extension SearchResultsVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        delegate?.didSelected(results[indexPath.row])
    }
}


