//
//  PopularPlacesView.swift
//  PopularPlacesView
//
//  Created by Mikhail Udotov on 2021-08-18.
//

import SwiftUI

struct PopularPlacesView: View {
    @ObservedObject var viewModel: PopularPlacesViewModel
    
    init() {
        self.viewModel = PopularPlacesViewModel(categories: [.art, .events, .parks, .sport])
    }
    
    var body: some View {
        ZStack {
            VStack {
                HStack() {
                    Text("Popular Places")
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
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 10) {
                            ForEach(viewModel.places, id: \.self) { popularPlace in
                                NavigationLink {
                                    PlaceView(place: popularPlace)
                                } label: {
                                    PopularPlaceCard(popularPlace: popularPlace)
                                }
                                
                            }
                        }.padding(.horizontal)
                    }
                }
            }
        }
    }
}

struct PopularPlacesView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
        PopularPlacesView()
    }
}
