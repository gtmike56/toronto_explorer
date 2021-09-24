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
        self.viewModel = PlacesViewModel(name: "New")
    }
    
    var body: some View {
        VStack {
            HStack() {
                Text("New Places").font(.system(size: 15, weight: .bold))
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
                        .font(.system(size: 17, weight: .heavy))
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
                                        Text(newPlace.name).font(.system(size: 17, weight: .bold))
                                        Image(systemName: viewModel.getimageName(category: newPlace.category))
                                            .font(.system(size: 15))
                                    }
                                    Text(newPlace.description)
                                        .font(.system(size: 12, weight: .regular))
                                        .lineLimit(5)
                                        .multilineTextAlignment(.leading)
                                }.foregroundColor(Color.primary)
                            }.padding(5)
                        }
                    }
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
