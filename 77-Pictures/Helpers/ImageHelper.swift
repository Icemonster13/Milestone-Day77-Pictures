//
//  ImageHelper.swift
//  77-Pictures
//
//  Created by Michael & Diana Pascucci on 5/27/22.
//

import SwiftUI

public func saveImageToDirectory(image: UIImage) -> String {
    if let data = image.jpegData(compressionQuality: 0.8) {
        let imageID = UUID()
        let filename = FileManager.documentsDirectory.appendingPathComponent("\(imageID).jpg")
        try? data.write(to: filename, options: [.atomic,.completeFileProtection])
        return "\(imageID).jpg"
    }
    return ""
}

public func loadImage(fileName: String) -> UIImage? {
    let fileURL = FileManager.documentsDirectory.appendingPathComponent(fileName)
    do {
        let imageData = try Data(contentsOf: fileURL)
        return UIImage(data: imageData)
    } catch {}
    return nil
}
