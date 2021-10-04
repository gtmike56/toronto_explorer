//
//  CategoryDetailsViewModel.swift
//  CategoryDetailsViewModel
//
//  Created by Mikhail Udotov on 2021-08-20.
//

import SwiftUI

final class PlacesViewModel: ObservableObject {
    @Published var isLoading = true
    @Published var places = [Place]()
    @Published var errorMessage = ""
    
    init(categoryName: String) {
        PlacesServiceAPI.placesServiceAPI.fetchPlaces(category: categoryName) { result in
            DispatchQueue.main.async {
                self.isLoading = false
                switch(result) {
                case .failure(.badURL):
                    self.errorMessage = "Server Error"
                    print("Invalid URL")
                case .failure(.noData):
                    self.errorMessage = "Server Error"
                    print("No data recieved from API call")
                case .failure(.jsonError):
                    self.errorMessage = "Server Error"
                    print("Invalid json")
                case .failure(.requestError):
                    self.errorMessage = "Server Error"
                    print("Request Error")
                case .success(let fetchedPlaces):
                    if fetchedPlaces.isEmpty {
                        self.errorMessage = "Sorry, No places yet in this category"
                    }
                    self.places = fetchedPlaces
                }
            }
        }
    }
}
