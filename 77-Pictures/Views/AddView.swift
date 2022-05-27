//
//  AddView.swift
//  77-Pictures
//
//  Created by Michael & Diana Pascucci on 5/27/22.
//

import SwiftUI

struct AddView: View {
    
    // MARK: - PROPERTIES
    @Environment(\.dismiss) var dismiss
    @ObservedObject var vm: CoreDataViewModel
    @State var picturename: String = ""
    @State var picturepath: String = ""
    
    // MARK: - BODY
    var body: some View {
        NavigationView {
            VStack {
                TextField("Add name here", text: $picturename)
                    .font(.headline)
                    .padding(.leading)
                    .frame(height: 55)
                    .background(.thinMaterial)
                    .cornerRadius(10)
                
                Button {
                    guard !picturename.isEmpty else { return }
                    vm.addPictureToEntity(name: picturename, imagePath: picturepath)
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
                
                Spacer()
            }
            .padding(.horizontal)
            .navigationTitle("Pictures")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

// MARK: - BODY
struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(vm: CoreDataViewModel())
    }
}
