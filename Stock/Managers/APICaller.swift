//
//  APICaller.swift
//  Stock
//
//  Created by AnatoliiOstapenko on 05.11.2022.
//

import Foundation

final class APICaller {
    
    static let shared = APICaller()
    private init() {}
    
    // MARK: - Public
    
    public func search(query: String, completion: @escaping(Result<SearchResponseModel, CustomErrors>) -> Void) {
        guard let safeQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            completion(.failure(.urlQueryIsNotAllowed))
            return
        }
        request(url: url(for: .search, queryParams: ["q": safeQuery]), expecting: SearchResponseModel.self, completion: completion)
    }
        
    // MARK: - Private
    
    private enum Endpoint: String { case search }
        
    private func url(for endpoint: Endpoint, queryParams: [String : String] = [:]) -> URL? {
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

