//
//  DetailView.swift
//  77-Pictures
//
//  Created by Michael & Diana Pascucci on 5/27/22.
//

import SwiftUI
import MapKit

struct Location: Identifiable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
}

struct DetailView: View {
    
    // MARK: - PROPERTIES
    let picture: PictureEntity
    @State private var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.5, longitude: -0.12), span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
    @State private var locations: [Location] = []
    
    // MARK: - BODY
    var body: some View {
        VStack {
            if let imageToLoad = loadImage(fileName: picture.notoptImage) {
                ZStack(alignment: .bottomTrailing) {
                    Image(uiImage: imageToLoad)
                        .resizable()
                        .scaledToFill()
                        .frame(height: 200)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
      
                    Text(picture.notoptName)
                        .font(.headline)
                        .padding(.horizontal)
                        .frame(height: 30)
                        .background(.thinMaterial)
                        .cornerRadius(10)
                        .offset(x: -5, y: -5)
                }
            }
            
            Section {
                Map(coordinateRegion: $mapRegion, annotationItems: locations) { location in
                    MapMarker(coordinate: location.coordinate)
                }
            } header: {
                Text("Where was this picture taken...")
                    .padding(.top)
            }

            Spacer()
        }
        .padding(.horizontal)
        .navigationTitle("Picture Details")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            mapRegion = MKCoordinateRegion(center: picture.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
            locations = [
                Location(name: picture.notoptName, coordinate: .init(latitude: picture.latitude, longitude: picture.longitude))
            ]
        }
    }
}

// MARK: - PREVIEW
//struct DetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailView(picture: PictureEntity(context: <#T##NSManagedObjectContext#>))
//    }
//}
