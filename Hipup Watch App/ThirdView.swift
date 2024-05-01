//
//  ThirdView.swift
//  Hipup Watch App
//
//  Created by Christine Putri on 29/04/24.

import SwiftUI
import AVFoundation

struct ThirdView: View {
    @State private var isFirstViewPresented = false
    @Binding var timer:Timer?

    let audioPath = AVPlayer(url: Bundle.main.url(forResource: "flush", withExtension: "wav")!)
    @Environment(\.presentationMode) var presentationMode

    @StateObject var audioPlayer = AudioPlayer()

    var body: some View {
        NavigationView{
            ZStack {
                ImageSequenceView3(imageNames3: getItem3())
                    .edgesIgnoringSafeArea(.all)
                
                //            NavigationLink(destination: FirstView().navigationBarBackButtonHidden(true), isActive: $isFirstViewPresented) {
                //                EmptyView()
                //            }.buttonStyle(PlainButtonStyle()) // Hide the navigation link button
                //                .onTapGesture {
                //                    self.isFirstViewPresented = true
                //                }
                //
                
                
                //                .fullScreenCover(isPresented: $isThirdViewPresented, content: {
                //                    ThirdView()
                //                })
            }
            .navigationBarHidden(true) // Hide the navigation bar
            .onTapGesture {
                self.isFirstViewPresented = true
            }
            .sheet(isPresented: $isFirstViewPresented) {
                FirstView()
            }
        }
            
        .task {
            Task {
                timer?.invalidate()
            }
            audioPath.play()
        }
        .navigationBarBackButtonHidden(true)
        .ignoresSafeArea()
//        .onAppear {
//            DispatchQueue.main.asyncAfter(deadline: .now()) {
//                self.audioPath.play()
//                Timer.scheduledTimer(withTimeInterval: 0.5 * Double(["mao"].count), repeats: false) { timer in
//                    self.audioPath.volume = 0
//                }
//            }
//        }
    }
}

class AudioPlayer: ObservableObject {
    var audioPlayer: AVAudioPlayer?
}

func getItem3() -> [String] {
    var imagesPath: [String] = []
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
        ThirdView(timer: .constant(Timer()))
    }
}
