//
//  DescriptionView.swift
//  
//
//  Created by 지준용 on 2023/04/19.
//

import SwiftUI
import AVFAudio

@available(iOS 16.0, *)
struct DescriptionView: View {
    
    // MARK: - Property
    
    @Environment(\.dismiss) var dismiss
    @Binding var audio: AVAudioPlayer!
    @State var isPlaying = true
    
    // MARK: - View
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 50) {
                HStack {
                    Button {
                        isPlaying.toggle()
                    } label: {
                        speakerImage
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundColor(.gray)
                            .aspectRatio(contentMode: .fit)
                    }
                    .padding([.top, .horizontal], 30)
                    
                    Spacer()
                    
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: ImageLiteral.xmark)
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundColor(.gray)
                            .aspectRatio(contentMode: .fit)
                    }
                    .padding([.top, .horizontal], 30)
                }
                
                VStack(alignment: .leading) {
                    Text(TextLiteral.appName)
                        .font(.system(.largeTitle, design: .rounded, weight: .semibold))
                    Text(TextLiteral.mainDescription)
                        .font(.system(.title2, design: .rounded, weight: .regular))
                        .lineLimit(3)
                }
                .padding(.horizontal, 30)
                
                VStack(alignment: .leading) {
                    Text(TextLiteral.readingABook)
                        .font(.system(.title, design: .rounded, weight: .semibold))
                    Text(TextLiteral.autoNextPicture)
                        .font(.system(.title2, design: .rounded, weight: .regular))
                    Text(TextLiteral.touchPicture)
                        .font(.system(.title2, design: .rounded, weight: .regular))
                        .lineLimit(2)
                }
                .padding(.horizontal, 30)
                
                VStack(alignment: .leading) {
                    Text(TextLiteral.pageList)
                        .font(.system(.title, design: .rounded, weight: .semibold))
                    Text(TextLiteral.addAndDeletePicture)
                        .font(.system(.title2, design: .rounded, weight: .regular))
                    Text(TextLiteral.touchPicture)
                        .font(.system(.title2, design: .rounded, weight: .regular))
                        .lineLimit(2)
                }
                .padding(.horizontal, 30)
                
                VStack(alignment: .center) {
                    Text(TextLiteral.attractAttention)
                        .font(.system(.title2, design: .rounded, weight: .semibold))
                        .lineLimit(2)
                }
                .padding(.horizontal, 30)
                
                Spacer()
            }
        }
        .border(.black, width: 10)
    }
    
    private var speakerImage: Image {
        if isPlaying {
            audio.numberOfLoops = -1
            audio.play()
        } else {
            audio.stop()
        }
        
        return Image(systemName: isPlaying ? ImageLiteral.playSound : ImageLiteral.stopSound)
    }
}
