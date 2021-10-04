//
//  CategoryDetailsView.swift
//  CategoryDetailsView
//
//  Created by Mikhail Udotov on 2021-08-20.
//

import SwiftUI

struct CategoryDetailsView: View {
    private let categoryName: String
    @ObservedObject var viewModel: PlacesViewModel
    
    init(name: String) {
        self.categoryName = name
        self.viewModel = PlacesViewModel(categoryName: categoryName)
    }
    
    var body: some View {
        ZStack {
            if viewModel.isLoading {
                ActivityIndicatorView()
            } else if viewModel.errorMessage != "" {
                VStack {
                    Image(systemName: "exclamationmark.triangle.fill")
                        .resizable()
                        .frame(width: 55, height: 55)
                        .foregroundColor(.orange)
                    Text("Sorry, No places yet for that category")
                        .font(Palette.CategoriesViewPalette.Fonts.error)
                }
                .padding()
            } else {
                ScrollView() {
                    ForEach(viewModel.places, id: \.self) { place in
                        NavigationLink {
                            PlaceView(place: place)
                        } label: {
                            VStack {
                                URLImage(place.thumbnail)
                                    .scaledToFill()
                                HStack() {
                                    Text(place.name)
                                        .lineLimit(1)
                                    Image(systemName: "star.fill")
                                    
                                    Text("\(place.rating, specifier: "%.1f")")
                                }
                                .font(Palette.CategoriesViewPalette.Fonts.title)
                                .padding(.bottom, 10)
                            }
                            .modifier(CardModifier())
                            .padding()
                        }.buttonStyle(.plain)
                        
                    }
                }
            }
        }.navigationBarTitle(categoryName, displayMode: .inline)
    }
}

struct CategoryDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CategoryDetailsView(name: "Art")
        }
    }
}
