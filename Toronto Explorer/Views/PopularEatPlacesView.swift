//
//  EatPlaces.swift
//  EatPlaces
//
//  Created by Mikhail Udotov on 2021-08-18.
//

import SwiftUI

struct PopularEatPlacesView: View {
    @ObservedObject var viewModel: PopularPlacesViewModel
    
    init() {
        self.viewModel = PopularPlacesViewModel(categories: [.food])
    }
    
    var body: some View {
        VStack {
            HStack() {
                Text("Popular places to eat")
                    .font(Palette.HomeScreenPalette.Fonts.sectionTitle)
                Spacer()
                Button {
                    viewModel.reloadData()
                } label: {
                    Image(systemName: "arrow.clockwise")
                        .font(Palette.HomeScreenPalette.Fonts.sectionButtonTitle)
                }.buttonStyle(.plain)
                
            }.padding()
            if viewModel.isLoading {
                ActivityIndicatorView()
                    .frame(height: 90)
            } else if viewModel.errorMessage != "" {
                VStack {
                    Image(systemName: "exclamationmark.triangle.fill")
                        .resizable()
                        .frame(width: 55, height: 55)
                        .foregroundColor(.orange)
                    Text(viewModel.errorMessage)
                        .font(Palette.HomeScreenPalette.Fonts.errorMessage)
                }
                .padding()
            } else {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 10) {
                        ForEach(viewModel.places, id: \.self) { restaurant in
                            NavigationLink(destination: PlaceView(place: restaurant)) {
                                PopularEatPlaceCard(popularPlace: restaurant)
                            }
                            
                        }
                    }.padding(.horizontal)
                }
            }
        }
    }
}

struct EatPlaces_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
        PopularEatPlacesView()
    }
}
