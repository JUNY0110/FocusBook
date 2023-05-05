//
//  PageListView.swift
//  
//
//  Created by 지준용 on 2023/04/14.
//

import SwiftUI

@available(iOS 16.0, *)
struct PageListView: View {
    
    // MARK: - Property
    
    let screenSize: CGFloat
    let coreDataManager = CoreDataManager.shared
    
    @Binding var images: [UIImage]
    @State private var isPresented = false
    
    // MARK: - View
    
    var body: some View {
        let columns = [GridItem(.adaptive(minimum: screenSize / 7))]
        
        ScrollView {
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(images.indices, id: \.self) { index in
                    NavigationLink {
                        Preview(images: $images, index: index)
                    } label: {
                        Image(uiImage: images[index])
                            .resizable()
                            .frame(width: self.screenSize / 7,
                                   height: self.screenSize / 7)
                            .border(.gray, width: 3)
                            .cornerRadius(8)
                            .aspectRatio(contentMode: .fit)
                    }
                }
                
                NavigationLink {
                    GridView(screenSize: screenSize, images: $images)
                } label: {
                    Image(uiImage: UIImage(named: ImageLiteral.plus)!)
                        .resizable()
                        .frame(width: self.screenSize / 7,
                               height: self.screenSize / 7)
                        .border(.gray, width: 3)
                        .cornerRadius(8)
                        .aspectRatio(contentMode: .fit)
                }
            }
        }
    }
}
