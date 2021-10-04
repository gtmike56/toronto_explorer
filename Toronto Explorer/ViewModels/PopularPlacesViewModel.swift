//
//  File.swift
//  File
//
//  Created by Mikhail Udotov on 2021-09-21.
//

import SwiftUI

final class PopularPlacesViewModel: ObservableObject {
    @Published var isLoading = true
    @Published var places = [Place]()
    @Published var errorMessage = ""
    let categories: [CategoryName]
    
    var dispatchGroup = DispatchGroup()
    
    init(categories: [CategoryName]) {
        self.categories = categories
        fetchData()
    }
    
    func fetchData(){
        categories.forEach { category in
            self.dispatchGroup.enter()
            PlacesServiceAPI.placesServiceAPI.fetchPlaces(category: category.rawValue) { result in
                switch(result) {
                case .failure(.badURL):
                    print("Invalid URL")
                case .failure(.noData):
                    print("No data recieved from API call")
                case .failure(.jsonError):
                    print("Invalid json")
                case .failure(.requestError):
                    print("Request Error")
                case .success(let fetchedPlaces):
                    DispatchQueue.main.async {
                        let tempPlaces = fetchedPlaces
                        self.places.append(contentsOf: tempPlaces)
                        self.dispatchGroup.leave()
                    }
                }
            }
            self.dispatchGroup.notify(queue: .main) {
                if self.places.isEmpty {
                    self.errorMessage = "Sorry, no places found"
                } else {
                    self.places.sort {
                        $0.rating > $1.rating
                    }
                }
                self.isLoading = false
            }
        }
    }
    
    func reloadData(){
        self.isLoading = true
        self.errorMessage = ""
        self.places = []
        
        fetchData()
    }
}
