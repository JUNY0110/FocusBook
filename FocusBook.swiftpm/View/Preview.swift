//
//  Preview.swift
//  
//
//  Created by 지준용 on 2023/04/17.
//

import SwiftUI

struct Preview: View {
    
    // MARK: - Property
    
    @Environment(\.dismiss) private var disiss
    
    @Binding var images: [UIImage]
    @State var index = 0
    
    // MARK: - View
    
    var body: some View {
        Image(uiImage: images[index])
            .resizable()
            .aspectRatio(contentMode: .fit)
            .toolbar {
                Button(TextLiteral.delete) {
                    images.remove(at: index)
                    disiss()
                }.foregroundColor(.red)
            }
    }
}
