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
            MainView(isPresented: $isPresented)
        }
        .onAppear {
            isPresented = true
            
            if let bgm = NSDataAsset(name: "bgm") {
                do {
                    self.audio = try AVAudioPlayer(data: bgm.data, fileTypeHint: "mp3")
                } catch {
                    print("[ERROR]: ContentView audio ERROR")
                }
            }
        }
        .sheet(isPresented: $isPresented) {
            DescriptionView(audio: $audio)
        }
    }
}
