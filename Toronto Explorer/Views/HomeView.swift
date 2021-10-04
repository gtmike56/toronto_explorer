//
//  ContentView.swift
//  Toronto Explorer
//
//  Created by Mikhail Udotov on 2021-08-16.
//

import SwiftUI

struct HomeView: View {
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [
            .foregroundColor: UIColor.init(white: 0.96, alpha: 1)
        ]
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(colors: Palette.GradientPalette.appBackground, startPoint: .top, endPoint: .bottom).ignoresSafeArea()
                
                Palette.HomeScreenPalette.Colors.appBackgroud
                    .offset(y: 300)
                
                ScrollView {
                    CategoriesView()
                    
                    VStack {
                        PopularPlacesView()
                        PopularEatPlacesView()
                        NewPlaces()
                    }.background(Palette.HomeScreenPalette.Colors.appBackgroud)
                        .cornerRadius(15)
                        .padding(.top, 25)
                }
                .navigationBarTitle("Toronto Explorer", displayMode: .large)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView().preferredColorScheme(.dark)
    }
}
