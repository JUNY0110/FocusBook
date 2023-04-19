//
//  ContentView.swift
//  WWDC2023Test
//
//  Created by 지준용 on 2023/04/14.
//

import SwiftUI
import AVFoundation

@available(iOS 16.0, *)
struct ContentView: View {
    
    // MARK: - Property
    
    @State var isPresented = false
    @State var audio: AVAudioPlayer!
    
    // MARK: - View
    
    var body: some View {
        NavigationView {
            MainView(audio: $audio, isPresented: $isPresented)
        }
        .onAppear {
            isPresented = true
            
            let bgm = NSDataAsset(name: TextLiteral.bgm)
            self.audio = try! AVAudioPlayer(data: bgm!.data, fileTypeHint: TextLiteral.mp3)
        }
        .sheet(isPresented: $isPresented) {
            DescriptionView(audio: $audio)
        }
    }
}

@available(iOS 16.0, *)
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
