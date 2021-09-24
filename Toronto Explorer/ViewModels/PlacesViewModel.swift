//
//  CategoryDetailsViewModel.swift
//  CategoryDetailsViewModel
//
//  Created by Mikhail Udotov on 2021-08-20.
//

import SwiftUI

class PlacesViewModel: ObservableObject {
    
    @Published var isLoading = true
    @Published var places = [Place]()
    @Published var errorMessage = ""
    
    init(name: String) {
        guard let url = URL(string: "https://raw.githubusercontent.com/gtmike56/gtmike56.github.io/main/Toronto-Explorer/\(name)/\(name.lowercased()).json") else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let data = data else {
                return
            }
            
            DispatchQueue.main.async {
                let resp = response as! HTTPURLResponse
                let statusCode = resp.statusCode
                if statusCode >= 400 {
                    self.errorMessage = "Server Error (\(statusCode))"
                    self.isLoading = false
                    return
                }
                
                do {
                    self.places = try JSONDecoder().decode([Place].self, from: data)
                } catch {
                    self.errorMessage = error.localizedDescription
                }
                
                self.isLoading = false
            }

        }.resume()
    }
    
    func getimageName(category: String) -> String {
        switch category {
        case "Art":
            return "paintpalette"
        case "Food":
            return "mappin"
        case "Park":
            return "leaf"
        case "Event":
            return "music.mic"
        case "Sport":
            return "sportscourt"
        default:
            return "questionmark.circle"
        }
    }
}
