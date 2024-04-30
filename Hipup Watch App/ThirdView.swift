//
//  ThirdView.swift
//  Hipup Watch App
//
//  Created by Christine Putri on 29/04/24.

import SwiftUI
import AVFoundation

struct ThirdView: View {
    @State private var isThirdViewPresented = false
    
    let audioPath = AVPlayer(url: Bundle.main.url(forResource: "flush", withExtension: "wav")!)
    @Environment(\.presentationMode) var presentationMode
    @StateObject var audioPlayer = AudioPlayer()
   
    
    var body: some View {
        ZStack {
            ImageSequenceView3(imageNames3: getItem3())
                .edgesIgnoringSafeArea(.all)
                
                .onTapGesture {
                    self.isThirdViewPresented = true
                }
                .fullScreenCover(isPresented: $isThirdViewPresented, content: {
                    ThirdView().navigationBarBackButtonHidden(true)
                })
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now()) {
                self.audioPath.play()
                Timer.scheduledTimer(withTimeInterval: 0.5 * Double(["mao"].count), repeats: false) { timer in
                    self.audioPath.volume = 0
                }
            }
        }
    }
}

class AudioPlayer: ObservableObject {
    var audioPlayer: AVAudioPlayer?
}

func getItem3() -> [String] {
    var imagesPath = ["Toilet fix for AE_"]
    for i in 0..<89 {
        imagesPath.append("Toilet fix for AE_\(String(format: "%05d", i))")
    }
    return imagesPath
}

struct ImageSequenceView3: View {
    var imageNames3: [String]
    @State private var currentIndex3 = 0
    
    var body: some View {
        Image(imageNames3[currentIndex3])
            .resizable()
            .scaledToFill()
            .edgesIgnoringSafeArea(.all)
            .onAppear {
                Timer.scheduledTimer(withTimeInterval: 0.03, repeats: true) { timer in
                    currentIndex3 = (currentIndex3 + 1) % imageNames3.count
                }
            }
    }
}

struct ThirdView_Previews: PreviewProvider {
    static var previews: some View {
        ThirdView()
    }
}
