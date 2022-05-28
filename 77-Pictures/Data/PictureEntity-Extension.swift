//
//  PictureEntity-Extension.swift
//  77-Pictures
//
//  Created by Michael & Diana Pascucci on 5/26/22.
//

import SwiftUI
import MapKit

extension PictureEntity {
    
    // MARK: - PROPERTIES
    var notoptName: String {
        name ?? "No name"
    }
    
    var notoptImage: String {
        imagepath ?? "No image"
    }
    
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}
