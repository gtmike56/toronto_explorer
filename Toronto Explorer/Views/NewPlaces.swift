//
//  NewPlacesView.swift
//  NewPlacesView
//
//  Created by Mikhail Udotov on 2021-09-20.
//

import SwiftUI

struct NewPlaces: View {
    @ObservedObject var viewModel: PlacesViewModel
    
    init() {
        self.viewModel = PlacesViewModel(categoryName: "New")
    }
    
    var body: some View {
        VStack {
            HStack() {
                Text("New Places")
                    .font(Palette.HomeScreenPalette.Fonts.sectionTitle)
                Spacer()
            }.padding()
            if viewModel.isLoading {
                ActivityIndicatorView()
                    .frame(height: 150)
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
                VStack(spacing: 10) {
                    ForEach(viewModel.places, id: \.self) { newPlace in
                        NavigationLink {
                            PlaceView(place: newPlace)
                        } label: {
                            HStack(spacing: 1) {
                                URLImage(newPlace.thumbnail)
                                    .frame(width: 135, height: 115)
                                    .cornerRadius(7)
                                    .scaledToFill()
                                    .cornerRadius(5)
                                VStack(alignment: .leading, spacing: 5) {
                                    HStack {
                                        Text(newPlace.name)
                                        Image(systemName: Helpers.getSystemImageName(category: newPlace.category))
                                    }.font(Palette.HomeScreenPalette.Fonts.placeTitle)
                                    
                                    Text(newPlace.description)
                                        .font(Palette.HomeScreenPalette.Fonts.placeDescription)
                                        .lineLimit(5)
                                        .multilineTextAlignment(.leading)
                                }
                            }.padding(5)
                        }
                    }.buttonStyle(.plain)
                        .modifier(CardModifier())
                }.padding([.bottom, .horizontal])
            }
        }
    }
}

struct TopUsersView_Previews: PreviewProvider {
    static var previews: some View {
        NewPlaces()
        HomeView()
    }
}
