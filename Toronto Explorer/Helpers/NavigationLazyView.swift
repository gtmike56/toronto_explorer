//
//  NavigationLazyView.swift
//  NavigationLazyView
//
//  Created by Mikhail Udotov on 2021-08-20.
//

import SwiftUI

struct NavigationLazyView <Content: View>: View {
    let build: () -> Content
    init(_ build: @autoclosure @escaping () -> Content) {
        self.build = build
    }
    var body: Content {
        build()
    }
}
