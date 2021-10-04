//
//  File.swift
//  File
//
//  Created by Mikhail Udotov on 2021-10-03.
//

import Foundation

enum APIError: Error {
    case badURL, noData, jsonError, requestError
}

class ServiceAPI {
    static let shared = ServiceAPI()
    
    func request<T: Decodable>(request: URLRequest, completion: @escaping (Result<T, APIError>) -> Void){
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            if let _ = error {
                completion(.failure(.requestError))
                return
            }
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            do {
                let result = try JSONDecoder().decode(T.self, from: data)
                completion(.success(result))
            } catch {
                completion(.failure(.jsonError))
            }
        }
        task.resume()
    }
}
