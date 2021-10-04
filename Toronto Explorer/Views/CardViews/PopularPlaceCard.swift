//
//  PopularPlaceCard.swift
//  PopularPlaceCard
//
//  Created by Mikhail Udotov on 2021-10-03.
//

import SwiftUI

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
                    .font(Palette.HomeScreenPalette.Fonts.placeTitle)
                Spacer()
                Image(systemName: "star.fill")
                    .font(Palette.HomeScreenPalette.Fonts.placeRating)
                Text("\(popularPlace.rating, specifier: "%.1f")")
                    .font(Palette.HomeScreenPalette.Fonts.placeRating)
            }.padding([.horizontal, .bottom], 10)
        }
        .foregroundColor(Color.primary)
        .frame(width: 200)
        .modifier(CardModifier())
        .padding(.bottom)
    }
}

struct PopularPlaceCard_Previews: PreviewProvider {
    static var previews: some View {
        PopularPlacesView()
    }
}
