//
//  HelperMapping.swift
//  HelperMapping
//
//  Created by Mikhail Udotov on 2021-10-03.
//

import SwiftUI

class Helpers {
    static func getSystemImageName(category: String) -> String {
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

enum Palette {
    enum GradientPalette {
        static let appBackground: [Color] = [.red, .yellow]
        static let restaurandHeader: [Color] = [.clear, .black]
    }
    
    enum HomeScreenPalette {
        enum Fonts {
            static let sectionTitle: Font = .system(size: 15, weight: .bold)
            static let sectionButtonTitle: Font = .system(size: 17, weight: .bold)
            
            static let errorMessage: Font = .system(size: 15, weight: .bold)
            
            static let placeTitle: Font = .system(size: 14, weight: .semibold)
            static let placeRating: Font = .system(size: 12, weight: .semibold)
            static let placeDescription: Font = .system(size: 12, weight: .regular)
            
        }
        enum Colors {
            static let appBackgroud: Color = Color("appBackground")
        }
    }
    
    enum PlaceViewPalette {
        enum Fonts {
            static let title: Font = .system(size: 18, weight: .bold)
            static let description: Font = .system(size: 16, weight: .medium)
        }
        
    }
    
    enum CategoriesViewPalette {
        enum Fonts {
            static let title: Font = .system(size: 16, weight: .bold)
            static let error: Font = .system(size: 17, weight: .heavy)
        }
    }
}
