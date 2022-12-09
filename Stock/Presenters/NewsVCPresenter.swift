//
//  NewsVCPresenter.swift
//  Stock
//
//  Created by AnatoliiOstapenko on 08.12.2022.
//

import Foundation
import UIKit

protocol NewsVCViewProtocol: AnyObject {
    func setNews(news: [NewsModel])
}

protocol NewsVCPresenterProtocol: AnyObject {
    init(view: NewsVCViewProtocol, networkManager: APICallerProtocol)
    func fetchNews()
}

class NewsVCPresenter: NewsVCPresenterProtocol {
    weak var view: NewsVCViewProtocol?
    private let networkManager: APICallerProtocol
    
    required init(view: NewsVCViewProtocol, networkManager: APICallerProtocol) {
        self.view = view
        self.networkManager = networkManager
    }
    
    func fetchNews() {
        networkManager.story(type: .company(symbol: "snap")) { [weak self] results in
            guard let self = self else { return }
            switch results {
            case .success(let success):
                DispatchQueue.main.async {
                    self.view?.setNews(news: success)
                }
            case .failure(let failure): print("Debug error: \(failure.rawValue)")
            }
        }
    }
    
    
}

