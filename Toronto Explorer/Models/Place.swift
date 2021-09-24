//
//  Place.swift
//  Place
//
//  Created by Mikhail Udotov on 2021-08-20.
//

import Foundation

struct Place: Decodable, Hashable {
    let name: String
    let thumbnail: String
    let description: String
    let category: String
    let latitude: Double
    let longitude: Double
    let rating: Double
    let photos: [String]
    let cuisine: String?
}
