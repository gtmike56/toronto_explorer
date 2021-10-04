//
//  Place.swift
//  Place
//
//  Created by Mikhail Udotov on 2021-08-20.
//

import Foundation

typealias imageURL = String

struct Place: Decodable, Hashable {
    let name: String
    let thumbnail: imageURL
    let description: String
    let category: String
    let latitude: Double
    let longitude: Double
    let rating: Double
    let photos: [imageURL]
    let cuisine: String?
}
