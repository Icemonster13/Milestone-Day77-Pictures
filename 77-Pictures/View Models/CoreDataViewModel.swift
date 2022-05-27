//
//  CoreDataViewModel.swift
//  77-Pictures
//
//  Created by Michael & Diana Pascucci on 5/27/22.
//

import SwiftUI
import CoreData

class CoreDataViewModel: ObservableObject {
    
    // MARK: - PROPERTIES
    @Published var savedPictures: [PictureEntity] = []
    
    // MARK: - INITIALIZER
    let container = NSPersistentContainer(name: "PicturesContainer")
    
    init() {
        container.loadPersistentStores { description, error in
            
            if let error = error {
                print("Failed to load data with error: \(error.localizedDescription)")
            } else {
                print("Successfully loaded core data!")
            }
            
            self.container.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
        }
        fetchPictures()
    }
    
    // MARK: - METHODS
    func fetchPictures() {
        let request = NSFetchRequest<PictureEntity>(entityName: "PictureEntity")
        
        do {
            savedPictures = try container.viewContext.fetch(request)
        } catch let error {
            print("Error fetching with error: \(error.localizedDescription)")
        }
    }
    
    func addPictureToEntity(name: String, imagePath: String) {
        
        let newPicture = PictureEntity(context: container.viewContext)
        newPicture.id = UUID()
        newPicture.name = name
        newPicture.imagepath = imagePath
        saveData()
    }
    
    func deletePictureFromEntity(indexSet: IndexSet) {
        guard let index = indexSet.first else { return }
        let picture = savedPictures[index]
        container.viewContext.delete(picture)
        saveData()
    }
    
    func updatePicture() {
        
    }
    
    func saveData() {
        do {
            try container.viewContext.save()
            fetchPictures()
        } catch let error {
            print("Error saving data to entity with error: \(error.localizedDescription)")
        }
    }
    
}
