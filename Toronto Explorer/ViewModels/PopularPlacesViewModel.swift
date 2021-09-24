//
//  File.swift
//  File
//
//  Created by Mikhail Udotov on 2021-09-21.
//

import SwiftUI

class PopularPlacesViewModel: ObservableObject {
    
    @Published var isLoading = true
    @Published var places = [Place]()
    @Published var errorMessage = ""
    
    var dispatchGroup = DispatchGroup()
    
    init(isEatingPlace: Bool) {
                
        if isEatingPlace {
            self.dispatchGroup.enter()
            getPlaces(name: "Food")
        } else {
            self.dispatchGroup.enter()
            getPlaces(name: "Art")
            self.dispatchGroup.enter()
            getPlaces(name: "Parks")
            self.dispatchGroup.enter()
            getPlaces(name: "Events")
            self.dispatchGroup.enter()
            getPlaces(name: "Sport")
        }
        self.dispatchGroup.notify(queue: .main) {
            
            if self.places.isEmpty {
                self.errorMessage = "Sorry, no places found"
                self.isLoading = false
            } else {
                self.places.sort {
                    $0.rating > $1.rating
                }
                self.isLoading = false
                self.places = Array(self.places.prefix(4))
                //self.places.shuffle()
            }

        }
    }
    
    func getPlaces(name: String) {
        
        guard let url = URL(string: "https://raw.githubusercontent.com/gtmike56/gtmike56.github.io/main/Toronto-Explorer/\(name)/\(name.lowercased()).json") else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let data = data else {
                return
            }
            DispatchQueue.main.async {
                do {
                    self.dispatchGroup.leave()
                    let tempPlaces = try JSONDecoder().decode([Place].self, from: data)
                    self.places.append(contentsOf: tempPlaces)
                } catch {
                    print(error)
                }
            }

        }.resume()
    }
    
}
