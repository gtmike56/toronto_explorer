//
//  ActivityIndicatorView.swift
//  ActivityIndicatorView
//
//  Created by Mikhail Udotov on 2021-08-20.
//

import SwiftUI

struct ActivityIndicatorView: UIViewRepresentable {
    typealias UIViewType = UIActivityIndicatorView
    
    func makeUIView(context: Context) -> UIActivityIndicatorView {
        let activityView = UIActivityIndicatorView(style: .large)
        activityView.startAnimating()
        return activityView
    }
    
    func updateUIView(_ uiView: UIActivityIndicatorView, context: Context) {}
}
