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
                .frame(width: self.screenSize * 0.9, height: self.screenSize * 0.9, alignment: .center)
                .aspectRatio(contentMode: .fit)
                .offset(y: self.isAnimating ? 0 : -100)
                .animation(.easeInOut(duration: 1.5).repeatForever(), value: self.isAnimating)
                .rotation3DEffect(.degrees(self.animationAmount), axis: (x: 0, y: 1, z: 0))
                .onAppear {
                    self.isAnimating = true
                }
                .onTapGesture {
                    self.index += 1
                    if self.index == self.images.count {
                        self.index = 0
                    }
                }
                .onReceive(timer) { _ in
                    if images.count > 1 {
                        self.seconds = (self.seconds == 5) ? 0 : (self.seconds + 1)
                        
                        if self.seconds.isMultiple(of: 5) && self.seconds != 0 {
                            self.index += 1
                            
                            withAnimation {
                                self.animationAmount += 180
                            }
                        }
                        
                        if self.index == (images.count - 1) {
                            self.index = 0
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
