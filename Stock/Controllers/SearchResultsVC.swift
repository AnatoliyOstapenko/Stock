//
//  SearchResultsVC.swift
//  Stock
//
//  Created by AnatoliiOstapenko on 05.11.2022.
//

import UIKit

protocol SearchResultsVCDelegate: AnyObject {
    func didSelected(_ companyName: String)
}

class SearchResultsVC: UIViewController {
    
    weak var delegate: SearchResultsVCDelegate?
    var results: [String] = []
    
    private let tableView: UITableView  = {
        let tableView = UITableView()
        tableView.register(SearchResultsCell.self, forCellReuseIdentifier: SearchResultsCell.reuseID)
        return tableView
    }()
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        setUpTablewView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    // MARK: - Public methods
    
    public func update(_ results: [String]) {
        self.results = results
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

extension SearchResultsVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchResultsCell.reuseID, for: indexPath) as! SearchResultsCell
        cell.textLabel?.text = "APPL"
        cell.detailTextLabel?.text = "Apple Inc."
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        delegate?.didSelected("APPL: \(indexPath.row)")
    }
    
}

