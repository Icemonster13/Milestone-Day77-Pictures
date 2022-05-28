//
//  AddView.swift
//  77-Pictures
//
//  Created by Michael & Diana Pascucci on 5/27/22.
//

import SwiftUI
import MapKit

struct AddView: View {
    
    // MARK: - PROPERTIES
    @Environment(\.dismiss) var dismiss
    @ObservedObject var vm: CoreDataViewModel
    
    @State private var image = UIImage()
    @State private var showImagePicker = false
    @State private var sourceType: Int = 1
    @State private var imageShowing = false
    
    @State private var picturename: String = ""
    @State private var picturepath: String = ""
    @State private var picturelatitude: Double = 0
    @State private var picturelongitude: Double = 0
    
    let locationFetcher = LocationFetcher()
    
    // MARK: - BODY
    var body: some View {
        NavigationView {
            VStack {
                Button {
                    showImagePicker = true
                    imageShowing = true
                } label: {
                    if imageShowing {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFill()
                            .frame(height: 200)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    } else {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .strokeBorder(lineWidth: 3)
                            Image(systemName: "camera")
                                .font(.largeTitle)
                        }
                        .frame(height: 200)
                    }
                }

                VStack {
                    Text("Select your photo from:")
                    Picker(selection: $sourceType, label: Text("Select photo from")) {
                        Image(systemName: "camera").tag(0)
                        Image(systemName: "folder").tag(1)
                    }
                    .padding(.bottom)
                    .pickerStyle(.segmented)
                }

                TextField("Image name here", text: $picturename)
                    .font(.headline)
                    .padding(.leading)
                    .frame(height: 55)
                    .background(.thinMaterial)
                    .cornerRadius(10)
                
                TextField("Image path here", text: $picturepath)
                    .font(.caption)
                    .padding(.leading)
                    .frame(height: 55)
                    .background(.thinMaterial)
                    .cornerRadius(10)
                
                HStack {
                    Text("Lat: \(picturelatitude)")
                    Spacer()
                    Text("Lon: \(picturelongitude)")
                }
                
                Button {
                    picturepath = saveImageToDirectory(image: image)
                    if let location = self.locationFetcher.lastKnownLocation {
                        picturelatitude = location.latitude
                        picturelongitude = location.longitude
                    }
                    guard !picturename.isEmpty else { return }
                    vm.addPictureToEntity(name: picturename, imagePath: picturepath, latitude: picturelatitude, longitude: picturelongitude)
                    dismiss()
                } label: {
                    Text("Save Picture")
                        .font(.headline)
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.white)
                        .background(.cyan)
                        .cornerRadius(10)
                }
                
//                Button("Start Tracking Location") {
//                    self.locationFetcher.start()
//                }
//
//                Button("Read Location") {
//                    if let location = self.locationFetcher.lastKnownLocation {
//                        print("Your location is \(location)")
//                    } else {
//                        print("Your location is unknown")
//                    }
//                }
                Spacer()
            }
            .padding(.horizontal)
            .navigationTitle("Pictures")
            .navigationBarTitleDisplayMode(.inline)
            .sheet(isPresented: $showImagePicker) {
                ImagePicker(sourceType: sourceType == 0 ? .camera : .photoLibrary, selectedImage: self.$image)
            }
            .onAppear {
                self.locationFetcher.start()
            }
        }
    }
}

// MARK: - BODY
struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(vm: CoreDataViewModel())
    }
}
