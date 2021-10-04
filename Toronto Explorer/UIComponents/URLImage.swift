//
//  URLImage.swift
//  URLImage
//
//  Created by Mikhail Udotov on 2021-10-03.
//

import SwiftUI

struct URLImage: View {
    @ObservedObject var imageLoader: ImageLoaderAndCache

    init(_ url: String) {
        imageLoader = ImageLoaderAndCache(imageURL: url)
    }

    var body: some View {
          Image(uiImage: UIImage(data: self.imageLoader.imageData) ?? UIImage())
            .resizable()
            .padding(5)
    }
}
