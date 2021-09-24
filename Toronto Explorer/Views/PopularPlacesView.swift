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
        self.viewModel = PopularPlacesViewModel(isEatingPlace: false)
    }
    
    var body: some View {
        ZStack {
            VStack {
                HStack() {
                    Text("Popular Places")
                        .font(.system(size: 15, weight: .bold))
                    Spacer()
                    Button() {
                        print("See all destinations tapped")
                    } label: {
                        NavigationLink {
                            CategoryDetailsView(name: "PopularPlaces")
                        } label: {
                            Text("See all").font(.system(size: 13, weight: .bold)).foregroundColor(Color.primary)
                        }

                    }
                    
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

struct PopularPlaceCard: View {
    
    var popularPlace: Place
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 0) {
            URLImage(popularPlace.thumbnail)
                .scaledToFill()
                .cornerRadius(5)
                .frame(width: 175)
                .clipped()
                .padding(10)
            
            HStack {
                Text(popularPlace.name)
                    .font(.system(size: 15, weight: .semibold))
                Spacer()
                Image(systemName: "star.fill")
                    .font(.system(size: 13, weight: .semibold))
                Text("\(popularPlace.rating, specifier: "%.1f")")
                    .font(.system(size: 13, weight: .semibold))
            }.padding([.horizontal, .bottom], 10)
        }
        .foregroundColor(Color.primary)
        .frame(width: 200)
        .modifier(CardModifier())
        .padding(.bottom)
    }
}
