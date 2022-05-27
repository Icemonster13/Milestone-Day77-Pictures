//
//  PictureEntity-Extension.swift
//  77-Pictures
//
//  Created by Michael & Diana Pascucci on 5/26/22.
//

import SwiftUI

extension PictureEntity {
    
    // MARK: - PROPERTIES
    var notoptName: String {
        name ?? "No name"
    }
    
    var notoptImage: String {
        name ?? "No image"
    }
}
