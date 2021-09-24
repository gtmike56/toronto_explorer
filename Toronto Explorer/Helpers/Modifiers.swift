//
//  Modifiers.swift
//  Modifiers
//
//  Created by Mikhail Udotov on 2021-08-18.
//

import SwiftUI

struct CardModifier: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .background(Color("mainColor"))
            .cornerRadius(5)
            .shadow(color: Color.secondary, radius: 3, x: 1, y: 3)
    }
    
}
