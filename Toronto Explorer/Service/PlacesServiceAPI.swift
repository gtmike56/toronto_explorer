//
//  PlacesServiceAPI.swift
//  PlacesServiceAPI
//
//  Created by Mikhail Udotov on 2021-10-03.
//

import Foundation

class PlacesServiceAPI {
    static let placesServiceAPI = PlacesServiceAPI()
    
    func fetchPlaces(category: String, completion: @escaping (Result<[Place], APIError>) -> Void) {
        guard let url = URL(string: "https://raw.githubusercontent.com/gtmike56/gtmike56.github.io/main/Toronto-Explorer/\(category)/\(category.lowercased()).json") else {
            completion(.failure(.badURL))
            return
        }
        
        let request = URLRequest(url: url)
        ServiceAPI.shared.request(request: request, completion: completion)
    }
}

