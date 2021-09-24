//
//  PhotosGridView.swift
//  PhotosGridView
//
//  Created by Mikhail Udotov on 2021-09-18.
//

import SwiftUI

struct PhotosGridView: View {
    
    var place: Place
    
    @State var isFullScreenPhoto = false
    @State var selectedImageIndex = 0
    
    var body: some View {
        GeometryReader { proxy in
            ScrollView {
                Spacer()
                    .fullScreenCover(isPresented: $isFullScreenPhoto) {
                        ZStack(alignment: .topLeading) {
                            Color.black.ignoresSafeArea()
                            
                            ImagesCarouselView(place: place, selectedImageIndex: selectedImageIndex)
                                
                            
                            Button {
                                isFullScreenPhoto.toggle()
                            } label: {
                                Image(systemName: "xmark")
                                    .foregroundColor(.white)
                                    .font(.system(size: 24, weight: .semibold))
                                    .padding()
                            }
                        }
                    }.opacity(isFullScreenPhoto ? 1 : 0)


                LazyVGrid(columns: [GridItem(.adaptive(minimum: proxy.size.width/3-1, maximum: 300), spacing: 1)], spacing: 1) {
                    ForEach(place.photos, id: \.self) { image in
                        Button {
                            isFullScreenPhoto.toggle()
                            self.selectedImageIndex = place.photos.firstIndex(of: image) ?? 0
                        } label: {
                            URLImage(image)
                                .scaledToFill()
                                .frame(width: proxy.size.width/3-5, height: proxy.size.width/3-5)
                                .clipped()
                        }

                    }
                }
            }
        }
        
    }
}

struct PhotosGridView_Preview: PreviewProvider {
    static var previews: some View {
        PhotosGridView(place: .init(name: "", thumbnail: "", description: "", category: "", latitude: 0.0, longitude: 0.0, rating: 0.0, photos: [], cuisine: ""))
    }
}
