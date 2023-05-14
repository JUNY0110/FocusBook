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
    @State private var animationAmount = 0.0
    @State private var seconds = 0
    @State private var isAnimating = false
    
    // MARK: - View
    
    var body: some View {
        if images.count > 0 {
            Image(uiImage: images[index])
                .resizable()
                .frame(width: screenSize * 0.9, height: screenSize * 0.9, alignment: .center)
                .aspectRatio(contentMode: .fit)
                .offset(y: self.isAnimating ? 0 : -100)
                .animation(.easeInOut(duration: 1.5).repeatForever(), value: self.isAnimating)
                .rotation3DEffect(.degrees(animationAmount), axis: (x: 0, y: 1, z: 0))
                .onAppear {
                    self.isAnimating = true
                }
                .onTapGesture {
                    index = (index == images.count - 1) ? 0 : (index + 1)
                    seconds = 0
                }
                .onReceive(timer) { _ in
                    if images.count > 0 {
                        seconds = (seconds == 5) ? 0 : (seconds + 1)
                        
                        if (seconds % 5 == 0) && seconds != 0 {
                            index = (index == images.count - 1) ? 0 : (index + 1)
                            
                            withAnimation {
                                animationAmount += 180
                            }
                        }
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
