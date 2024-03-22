//
//  ImageFileManager.swift
//  FocusBook
//
//  Created by 지준용 on 3/22/24.
//

import SwiftUI


final class ImageFileManager {
    static let shared = ImageFileManager()
    private let fileManager = FileManager.default
    private var dateString: String {
        let date =  Date()
        let myFormatter = DateFormatter()
        myFormatter.dateFormat = "yyyyMMddHHmmss"
        
        let dateString = myFormatter.string(from: date)
        return dateString
    }
    
    private init() {}
    
    func saveImageToDirectory(image: UIImage) {
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory,in: .userDomainMask).first else { return }
        let imageName = "\(dateString)_image"
        let fileURL = documentsDirectory.appendingPathComponent(imageName, conformingTo: .jpeg)
        
        do {
            if let imageData = image.jpegData(compressionQuality: 1) {
                try imageData.write(to: fileURL)
                print("Image saved at: \(fileURL)")
            }
            
        } catch {
            print("Failed to save images: \(error)")
        }
    }
    
    func loadAllImageFromDirectory() -> [UIImage] {
        guard let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return [] }

        do {
            var fileURLs = try fileManager.contentsOfDirectory(at: documentsDirectory, includingPropertiesForKeys: nil)
            
            if fileURLs.count > 1 {
                fileURLs.sort {
                    $0.pathComponents.last! > $1.pathComponents.last!
                }
            }
            
            var images = fileURLs.compactMap {
                UIImage(contentsOfFile: $0.path)
            }
            
            if let plusImage = UIImage(named: ImageLiteral.plus), !images.contains(plusImage) {
                images.append(plusImage)
            }
            
            return images
        } catch {
            print("Error reading directory \(error)")
        }
        
        return []
    }
    
    func deleteImageFromDirectory(_ index: Int) {
        guard let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        
        do {
            var fileURLs = try fileManager.contentsOfDirectory(at: documentsDirectory, includingPropertiesForKeys: nil)
            
            if fileURLs.count > 1 {
                fileURLs.sort {
                    $0.pathComponents.last! > $1.pathComponents.last!
                }
            }
            
            guard let fileName = fileURLs[index].pathComponents.last else { return }
            
            let fileURL = documentsDirectory.appendingPathComponent(fileName)
            try fileManager.removeItem(at: fileURL)
        } catch {
            print("Error to delete directory \(error)")
        }
    }
}
