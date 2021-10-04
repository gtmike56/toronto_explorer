//
//  PopularEatPlaceCard.swift
//  PopularEatPlaceCard
//
//  Created by Mikhail Udotov on 2021-10-03.
//

import SwiftUI

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
                    .font(Palette.HomeScreenPalette.Fonts.placeTitle)
                    .lineLimit(2)
                
                HStack() {
                    Image(systemName: "star.fill")
                    Text("\(popularPlace.rating, specifier: "%.1f")")
                    Text("•")
                    Text(popularPlace.cuisine ?? "")
                    Spacer()
                }.font(Palette.HomeScreenPalette.Fonts.placeRating)
                
            }
            .foregroundColor(Color.primary)
        }
        .frame(width: 250)
        .modifier(CardModifier())
        .padding(.bottom)
    }
}

struct PopularEatPlaceCard_Previews: PreviewProvider {
    static var previews: some View {
        PopularEatPlacesView()
    }
}
