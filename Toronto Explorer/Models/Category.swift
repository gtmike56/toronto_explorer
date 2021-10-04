//
//  Category.swift
//  Category
//
//  Created by Mikhail Udotov on 2021-08-16.
//

import Foundation
import UIKit

struct Category: Hashable {
    let name: String
    let systemImage: String
}

enum CategoryName: String {
    case art = "Art"
    case parks = "Parks"
    case food = "Food"
    case events = "Events"
    case sport = "Sport"
}
