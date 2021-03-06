//
//  ContentView.swift
//  77-Pictures
//
//  Created by Michael & Diana Pascucci on 5/26/22.
//

import SwiftUI

struct ContentView: View {
    
    // MARK: - PROPERTIES
    @StateObject private var vm = CoreDataViewModel()
    @State private var showingAddItem: Bool = false
    
    // MARK: - BODY
    var body: some View {
        NavigationView {
            List {
                ForEach(vm.savedPictures) { picture in
                    NavigationLink {
                        DetailView(picture: picture)
                    } label: {
                        VStack(alignment: .leading) {
                            HStack {
                                if let imageToLoad = loadImage(fileName: picture.notoptImage) {
                                    Image(uiImage: imageToLoad)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 48, height: 48)
                                } else {
                                    Image(systemName: "person")
                                }
                                Text(picture.notoptName)
                            }
                            Text(picture.notoptImage)
                                .font(.caption2)
                        }
                    }

                }
                .onDelete(perform: vm.deletePictureFromEntity)
                .listStyle(.plain)
            }
            .navigationTitle("Pictures")
            .toolbar {
                Button {
                    showingAddItem = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showingAddItem) {
                AddView(vm: vm)
            }
        }
    }
}

// MARK: - PREVIEW
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
