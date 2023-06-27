//
//  FocusBookView.swift
//  
//
//  Created by 지준용 on 2023/04/14.
//

import SwiftUI

struct FocusBookView: View {
    
    // MARK: - Property
    
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    let screenSize: CGFloat
    
    @Binding var images: [UIImage]
    
    @State private var index = 0
    @State private var seconds = 0
    @State private var isAnimating = false
    
    // MARK: - View
    
    var body: some View {
        if images.count > 1 {
            Image(uiImage: images[index])
                .resizable()
                .frame(width: screenSize * 0.8, height: screenSize * 0.8, alignment: .center)
                .aspectRatio(contentMode: .fit)
                .offset(x: self.isAnimating ? UIScreen.main.bounds.width * 0.8: -UIScreen.main.bounds.width * 0.8)
                .animation(.linear(duration: 15).repeatForever(), value: self.isAnimating)
                .onAppear {
                    self.isAnimating = true
                }
                .onTapGesture {
                    index = (index == images.endIndex - 2) ? 0 : (index + 1)
                }
                .onReceive(timer) { _ in
                    seconds = (seconds == 15) ? 1 : (seconds + 1)

                    if (seconds % 15 == 0) && seconds != 0 {
                        index = (index == images.count - 2) ? 0 : (index + 1)
                    }
                }
        } else {
            Text("페이지 목록에서 이미지를 추가해주세요!")
                .foregroundColor(.secondary)
                .font(.system(size: 30, weight: .bold, design: .rounded))
                .padding()
        }
    }
}
