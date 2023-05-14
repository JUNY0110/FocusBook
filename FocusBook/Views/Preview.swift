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
    @Environment(\.managedObjectContext) var viewContext
    
    @FetchRequest(entity: Page.entity(),
                  sortDescriptors: [NSSortDescriptor(keyPath: \Page.image, ascending: true)])
    var pages: FetchedResults<Page>
    
    @Binding var images: [UIImage] {
        didSet {
            self.dismiss()
        }
    }
    let index: Int
    
    let coreDataManager = CoreDataManager.shared
    
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
        coreDataManager.deleteImage(object: pages[index])
        images.remove(at: index)
    }
}
