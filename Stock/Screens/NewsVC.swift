//
//  NewsVC.swift
//  Stock
//
//  Created by AnatoliiOstapenko on 05.11.2022.
//

import UIKit

enum NewsType {
    case topStories, company(symbol: String)
    
    var title: String {
        switch self {
        case .topStories: return "Top Stories"
        case .company(symbol: let symbol): return symbol.uppercased()
        }
    }
}

class NewsVC: UIViewController {
    
    let tableView = UITableView()
    private let type: NewsType
    
    var presenter: NewsVCPresenterProtocol?
    var coordinator: WatchListCoordinatorProtocol?
    
    var stories: [NewsModel] = []
    
    init(type: NewsType) {
        self.type = type
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setUpTableView()
        presenter?.fetchNews()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds // it's working well if you have a portret orientation only
    }
    
    // MARK: - Private methods
    
    private func setUpTableView() {
        view.addSubview(tableView)
        tableView.backgroundColor = .clear
        tableView.register(NewsCell.self, forCellReuseIdentifier: String(describing: NewsCell.self))
        tableView.register(NewsHeaderView.self, forHeaderFooterViewReuseIdentifier: String(describing: NewsHeaderView.self))
        tableView.dataSource = self
        tableView.delegate = self
        
        // FIXME: - use this after to check what diference
//        tableView.estimatedRowHeight = NewsCell.preferedHeight
//        tableView.rowHeight = UITableView.automaticDimension
    }
}

// MARK: - UITableViewDataSource

extension NewsVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: NewsCell.self), for: indexPath) as? NewsCell else {
            fatalError("Debug error: Issue with adding NewsCell into tableView")
        }
        // FIXME: - try this line and NewsCellModel, it seems to be easier than init
//        cell.updateNewsCell(with: stories[indexPath.row])
        
        cell.updateNewsCell(with: .init(model: stories[indexPath.row]))
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: String(describing: NewsHeaderView.self)) as? NewsHeaderView else {
            print("Debug error: Issue with adding NewsHeaderView into tableView")
            return nil
        }
        header.updateNewsHeader(with: .init(title: self.type.title, shouldShowAddButton: false))
        return header
    }
}

// MARK: - UITableViewDelegate

extension NewsVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return NewsHeaderView.preferredHeight
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return NewsCell.preferedHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        // Open web news story
        let story = stories[indexPath.row]
        guard let url = URL(string: story.url) else {
            coordinator?.setUpAlert(viewController: self, text: .urlIsNil)
            return
        }
        coordinator?.setUpAlert(viewController: self, text: .urlIsNil)
//        coordinator?.setUpSafari(url: url, viewController: self)
    }
}

extension NewsVC: NewsVCViewProtocol {
    func setNews(news: [NewsModel]) {
        self.stories = news
        self.tableView.reloadData()
    }
    
    
}
