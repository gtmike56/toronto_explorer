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
        self.viewModel = PlacesViewModel(name: name)
    }
    
    var body: some View {
        
        ZStack {
            if viewModel.isLoading {
                ActivityIndicatorView()
            } else if viewModel.errorMessage != "" || (viewModel.places.isEmpty &&  viewModel.errorMessage == "") {
                VStack {
                    Image(systemName: "exclamationmark.triangle.fill")
                        .resizable()
                        .frame(width: 55, height: 55)
                        .foregroundColor(.orange)
                    if viewModel.errorMessage == "" {
                        Text("Sorry, No places yet for that category")
                            .font(.system(size: 17, weight: .heavy))
                    } else {
                        Text(viewModel.errorMessage)
                            .font(.system(size: 17, weight: .heavy))
                    }
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
                                        .font(.system(size: 17, weight: .medium))
                                        .lineLimit(1)
                                    Image(systemName: "star.fill")
                                        .font(.system(size: 15))
                                    Text("\(place.rating, specifier: "%.1f")")
                                        .font(.system(size: 17, weight: .medium))
                                }
                                .padding(.bottom, 10)
                                .foregroundColor(Color.primary)
                            }
                            .modifier(CardModifier())
                            .padding()
                        }
                        
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
