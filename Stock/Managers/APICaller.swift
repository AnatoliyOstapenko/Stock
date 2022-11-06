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
    
    // MARK: - Private
    
    private enum Endpoint: String { case search }
        
    private func url(for endpoint: Endpoint, queryParams: [String : String] = [:]) -> URL? {
        return URL(string: "www")
    }
    
    private func request<T: Codable>(url: URL?, expecting: T.Type, completion: @escaping(Result<T,CustomErrors>) -> Void) {
        guard let url = url else {
            completion(.failure(.urlNil))
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

