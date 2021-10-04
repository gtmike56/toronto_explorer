//
//  PlaceView.swift
//  PlaceView
//
//  Created by Mikhail Udotov on 2021-09-10.
//

import SwiftUI
import MapKit

struct PlaceView: View {
    let place: Place
    let anotations: [Annotation]
    
    @State var region: MKCoordinateRegion
    @State var isShowingPin = true
    
    init(place: Place) {
        self.place = place
        self._region = State(initialValue: MKCoordinateRegion(center: .init(latitude: place.latitude, longitude: place.longitude), span: .init(latitudeDelta: 0.01, longitudeDelta: 0.01)))
        self.anotations = [.init(name: place.name, latitude: place.latitude, longitude: place.longitude)]
    }
    
    var body: some View {
        ScrollView {
            if place.cuisine == nil {
                ImagesCarouselView(place: place, selectedImageIndex: 0)
                    .frame(height: 280)
            } else {
                ZStack(alignment: .bottomLeading) {
                    URLImage(place.thumbnail)
                        .scaledToFill()
                    LinearGradient(gradient: Gradient(colors: Palette.GradientPalette.restaurandHeader), startPoint: .center, endPoint: .bottom)
                    HStack {
                        VStack(alignment: .leading) {
                            Text(place.name)
                                .foregroundColor(.white)
                                .font(Palette.PlaceViewPalette.Fonts.title)
                            HStack(spacing: 1) {
                                ForEach(0..<Int(place.rating.rounded()), id: \.self) { num in
                                    Image(systemName: "star.fill")
                                        .foregroundColor(.orange)
                                }
                            }
                        }
                        .padding()
                        Spacer()
                        NavigationLink(destination: PhotosGridView(place: place)) {
                            Text("See more photos")
                                .foregroundColor(Color.white)
                                .font(Palette.PlaceViewPalette.Fonts.description)
                                .frame(width: 80)
                        }
                    }
                }
            }
            
            VStack(alignment: .leading, spacing: 10) {
                if place.cuisine == nil {
                    Text(place.name)
                        .font(Palette.PlaceViewPalette.Fonts.title)
                    HStack(spacing: 1) {
                        ForEach(0..<Int(place.rating.rounded()), id: \.self) { num in
                            Image(systemName: "star.fill")
                                .foregroundColor(.orange)
                        }
                    }
                }
                Text(place.description)
                    .font(Palette.PlaceViewPalette.Fonts.description)
                
                HStack {
                    Spacer()
                }
            }.padding(10)
            
            HStack() {
                Text("Location")
                    .font(Palette.PlaceViewPalette.Fonts.title)
                Spacer()
                Button {
                    isShowingPin.toggle()
                } label: {
                    Text("\(isShowingPin ? "Hide" : "Show") Mark")
                        .foregroundColor(Color.primary)
                        .font(Palette.PlaceViewPalette.Fonts.title)
                }
                Toggle("", isOn: $isShowingPin)
                    .labelsHidden()
                
            }.padding(.horizontal)
            Button {
                if let url = URL(string: "maps://?saddr=&daddr=\(place.latitude),\(place.longitude)") {
                    if UIApplication.shared.canOpenURL(url) {
                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                    }
                }
                
            } label: {
                Map(coordinateRegion: $region, interactionModes: .zoom ,annotationItems: isShowingPin ? anotations : [], annotationContent: { pin in
                    MapMarker(coordinate: .init(latitude: pin.latitude, longitude: pin.longitude), tint: .orange)
                })
                    .frame(height: 250)
            }
        }.navigationBarTitle(place.name, displayMode: .inline)
    }
}

struct Annotation: Identifiable {
    let id = UUID()
    let name: String
    let latitude: Double
    let longitude: Double
}

struct PlaceView_Previews: PreviewProvider {
    static var previews: some View {
        PlaceView(place: .init(name: "Borscht", thumbnail: "https://ychef.files.bbci.co.uk/976x549/p07ryyyj.jpg", description: "Test Description \n\n\n Yay \n\n\n\n\n Test", category: "Test", latitude: 43.642567, longitude: -79.387054, rating: 3.5, photos: ["https://icatcare.org/app/uploads/2018/07/Thinking-of-getting-a-cat.png", "https://ychef.files.bbci.co.uk/976x549/p07ryyyj.jpg"], cuisine: "Ukranian"))
        HomeView()
    }
}
