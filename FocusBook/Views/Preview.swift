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
            index = 0
            self.dismiss()
        }
    }
    @State var index = 0
    
    let coreDataManager = CoreDataManager.shared
    
    // MARK: - View
    
    var body: some View {
        Image(uiImage: images[index])
            .resizable()
            .aspectRatio(contentMode: .fit)
//            .toolbar {
//                if images.count > 1 {
//                    Button(TextLiteral.delete) {
//                        deleteImage(index: index)
//                    }.foregroundColor(.red)
//                }
//            }
    }
    
    func deleteImage(index: Int) {
        coreDataManager.deleteImage(object: pages[index])
        images.remove(at: index)
    }
}
