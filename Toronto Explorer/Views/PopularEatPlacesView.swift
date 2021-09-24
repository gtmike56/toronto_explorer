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
        self.viewModel = PopularPlacesViewModel(isEatingPlace: true)
    }
    
    var body: some View {
        VStack {
            HStack() {
                Text("Popular places to eat").font(.system(size: 15, weight: .bold))
                Spacer()
                Button() {
                    print("Eating places tapped")
                } label: {
                    NavigationLink {
                        CategoryDetailsView(name: "Food")
                    } label: {
                        Text("See all").font(.system(size: 13, weight: .bold)).foregroundColor(Color.primary)
                    }
                }

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
                        .font(.system(size: 17, weight: .heavy))
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

struct PopularEatPlaceCard: View {
    
    var popularPlace: Place
    
    var body: some View {
        HStack(alignment: .center) {
            URLImage(popularPlace.thumbnail)
                .scaledToFill()
                .frame(width: 90, height: 75)
                .cornerRadius(5)
                .padding([.vertical, .trailing], 3)
                .padding(.leading, 6)
            Spacer()
            VStack(alignment: .leading, spacing: 3) {
                Text(popularPlace.name)
                    .font(.system(size: 14, weight: .semibold))
                    .lineLimit(2)
                
                HStack() {
                    Image(systemName: "star.fill")
                    Text("\(popularPlace.rating, specifier: "%.1f")")
                    Text("•")
                    Text(popularPlace.cuisine ?? "")
                    Spacer()
                }.font(.system(size: 12, weight: .semibold))
                
            }
            .foregroundColor(Color.primary)
        }
        .frame(width: 250)
        .modifier(CardModifier())
        .padding(.bottom)
    }
}
