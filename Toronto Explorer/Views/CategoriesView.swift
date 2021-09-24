//
//  CategoriesView.swift
//  CategoriesView
//
//  Created by Mikhail Udotov on 2021-08-18.
//

import SwiftUI

struct CategoriesView: View {
    
    let categories: [Category] = [.init(name: "Art", systemImage: "paintpalette.fill"),
                                    .init(name: "Parks", systemImage: "leaf.fill"),
                                    .init(name: "Food", systemImage: "mappin.circle.fill"),
                                    .init(name: "Events", systemImage: "music.mic"),
                                    .init(name: "Sport", systemImage: "sportscourt.fill")]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 15) {
                ForEach(categories, id: \.self) { category in
                    VStack(spacing: 5) {
                        NavigationLink {
                            NavigationLazyView(CategoryDetailsView(name: category.name))
                        } label: {
                            Image(systemName: category.systemImage)
                                .font(.system(size: 30))
                                .foregroundColor(.orange)
                                .frame(width: 70, height: 70)
                                .background(Color.white)
                                .clipShape(Circle())
                                .shadow(color: .orange, radius: 2, x: 2, y: 4)
                        }
                        Text(category.name)
                            .font(.system(size: 15, weight: .bold))
                            .multilineTextAlignment(.center)
                            .foregroundColor(.white)
                    }
                }
                
                
            }.padding(.horizontal)
        }
    }
}

struct CategoriesView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
        CategoriesView()
    }
}
