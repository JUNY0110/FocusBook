//
//  Preview.swift
//  
//
//  Created by 지준용 on 2023/04/17.
//

import SwiftUI

struct Preview: View {
    
    // MARK: - Property
    
    @Environment(\.dismiss) private var dismiss

    let index: Int
    let imageFileManager = ImageFileManager.shared

    @Binding var images: [UIImage] {
        didSet {
            dismiss()
        }
    }

    // MARK: - View
    
    var body: some View {
        Image(uiImage: images[index])
            .resizable()
            .aspectRatio(contentMode: .fit)
            .toolbar {
                Button(TextLiteral.delete) {
                    deleteImage(index: index)
                }.foregroundColor(.red)
            }
    }
    
    func deleteImage(index: Int) {
        imageFileManager.deleteImageFromDirectory(index)
        images = imageFileManager.loadAllImageFromDirectory()
    }
}
