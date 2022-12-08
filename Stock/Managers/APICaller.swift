//
//  APICaller.swift
//  Stock
//
//  Created by AnatoliiOstapenko on 05.11.2022.
//

import Foundation

protocol APICallerProtocol {
    func search(query: String, completion: @escaping(Result<SearchResponseModel, CustomErrors>) -> Void)
    func story(type: NewsType, completion: @escaping(Result<[NewsModel], CustomErrors>) -> Void)
}

final class APICaller: APICallerProtocol {
    
    static let shared = APICaller() // FIXME: - Delete this after debbuging
//    private init() {}
    
    // MARK: - Public
    
    public func search(query: String, completion: @escaping(Result<SearchResponseModel, CustomErrors>) -> Void) {
        // disable to type not url format query request by user
        guard let safeQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            completion(.failure(.urlQueryIsNotAllowed))
            return
        }
        request(url: getURL(for: .search, queryParams: ["q": safeQuery]), expecting: SearchResponseModel.self, completion: completion)
    }
    
    public func story(type: NewsType, completion: @escaping(Result<[NewsModel], CustomErrors>) -> Void) {
//        let formater = DateFormatter()
        let today = Date()
        let yesterday = today.addingTimeInterval(-(Constants.interval * 1)) //intrerval * days
        
        switch type {
        case .topStories:
            request(url: getURL(for: .news, queryParams: ["category":"general"]), expecting: [NewsModel].self, completion: completion)
        case .company(let symbol):
            request(url: getURL(for: .company, queryParams: ["symbol":symbol,
                                                          "from":yesterday.dateToString,
                                                          "to":today.dateToString]),
                    expecting: [NewsModel].self, completion: completion)
        }
    }
        
    // MARK: - Private
    
    private enum Endpoint: String { case search, news, company = "company-news" }
        
    private func getURL(for endpoint: Endpoint, queryParams: [String : String] = [:]) -> URL? {
        var urlString = Constants.baseURL + endpoint.rawValue
        var queryItems = [URLQueryItem]()
        
        queryParams.forEach { name, value in
            queryItems.append(.init(name: name, value: value))
        }
        queryItems.append(.init(name: "token", value: Password.key)) // Add token
        urlString += "?" + queryItems.map {"\($0.name)=\($0.value ?? "")"}.joined(separator: "&")
        
        print(urlString)
        return URL(string: urlString)
    }
    
    private func request<T: Codable>(url: URL?, expecting: T.Type, completion: @escaping(Result<T, CustomErrors>) -> Void) {
        guard let url = url else {
            completion(.failure(.urlRequestIsNil))
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard error == nil, let data = data else {
                completion(.failure(.taskFail))
                return
            }
            do {
                let result = try JSONDecoder().decode(expecting, from: data)
                completion(.success(result))
                
            } catch { completion(.failure(.decodeFail))}
        }
        task.resume()
    }
}

