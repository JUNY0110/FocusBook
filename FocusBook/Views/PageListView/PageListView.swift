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
    
    @Binding var images: [UIImage]
    @State private var isPresented = false
    
    // MARK: - View
    
    var body: some View {
        let columns = [GridItem(.adaptive(minimum: screenSize / 7))]
        
        ScrollView {
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(images.indices, id: \.self) { index in
                    NavigationLink {
                        if index == (images.endIndex - 1) {
                            GridView(screenSize: screenSize, images: $images)
                        } else {
                            Preview(index: index, images: $images)
                        }
                    } label: {
                        Image(uiImage: images[index])
                            .resizable()
                            .frame(width: screenSize / 7,
                                   height: screenSize / 7)
                            .border(.gray, width: 3)
                            .cornerRadius(8)
                            .aspectRatio(contentMode: .fit)
                    }
                }
            }
        }
    }
}
