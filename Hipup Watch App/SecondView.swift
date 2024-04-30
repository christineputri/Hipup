////
////  SecondView.swift
////  Hipup Watch App
////
////  Created by Christine Putri on 29/04/24.
////
//
//import SwiftUI
//
//struct SecondView: View {
//    @State private var isThirdViewPresented = false
//    
//    var body: some View {
//        NavigationView {
//            ZStack {
//                ImageSequenceView2(imageNames2: getItem2())
//                    .edgesIgnoringSafeArea(.all)
//                
//                NavigationLink(destination: ThirdView().navigationBarBackButtonHidden(true), isActive: $isThirdViewPresented) {
//                    EmptyView()
//                }
//            }
//            .onTapGesture {
//                self.isThirdViewPresented = true
//            }
//        }
//    }
//    
//    func getItem2() -> [String] {
//        var imagesPath = ["fix mantep ekor bener_"]
//        for i in 0..<389 {
//            imagesPath.append("fix mantep ekor bener_\(String(format: "%05d", i))")
//        }
//        return imagesPath
//    }
//}
//
//struct ImageSequenceView2: View {
//    var imageNames2: [String]
//    @State private var currentIndex2 = 0
//    
//    var body: some View {
//        Image(imageNames2[currentIndex2])
//            .resizable()
//            .scaledToFill()
//            .edgesIgnoringSafeArea(.all)
//            .onAppear {
//                Timer.scheduledTimer(withTimeInterval: 0.033, repeats: true) { timer in
//                    currentIndex2 = (currentIndex2 + 1) % imageNames2.count
//                }
//            }
//    }
//}
//
//struct SecondView_Previews: PreviewProvider {
//    static var previews: some View {
//        SecondView()
//    }
//}

//import SwiftUI
//import AVFoundation
//
//struct SecondView: View {
//    @State private var isThirdViewPresented = false
//    let audioPath = AVPlayer(url: Bundle.main.url(forResource: "flush", withExtension: "wav")!)
//    @StateObject var audioPlayer = AudioPlayer()
//    
//    var body: some View {
//        NavigationView {
//            ZStack {
//                ImageSequenceView2(imageNames2: getItem2())
//                    .edgesIgnoringSafeArea(.all)
//                
//                NavigationLink(destination: ThirdView().navigationBarBackButtonHidden(true), isActive: $isThirdViewPresented) {
//                    EmptyView()
//                }
//            }
//            .onTapGesture {
//                self.isThirdViewPresented = true
//            }
//        }
//        .onAppear {
//            DispatchQueue.main.async {
//                self.playAudio()
//            }
//        }
//    }
//    
//    func getItem2() -> [String] {
//        var imagesPath = ["fix mantep ekor bener_"]
//        for i in 0..<389 {
//            imagesPath.append("fix mantep ekor bener_\(String(format: "%05d", i))")
//        }
//        return imagesPath
//    }
//    
//    func playAudio() {
//        audioPath.play()
//        Timer.scheduledTimer(withTimeInterval: 0.5 * Double(["mao"].count), repeats: false) { timer in
//            self.audioPath.volume = 0
//        }
//    }
//}
//
//struct ImageSequenceView2: View {
//    var imageNames2: [String]
//    @State private var currentIndex2 = 0
//    
//    var body: some View {
//        Image(imageNames2[currentIndex2])
//            .resizable()
//            .scaledToFill()
//            .edgesIgnoringSafeArea(.all)
//            .onAppear {
//                Timer.scheduledTimer(withTimeInterval: 0.033, repeats: true) { timer in
//                    currentIndex2 = (currentIndex2 + 1) % imageNames2.count
//                }
//            }
//    }
//}
//
//struct SecondView_Previews: PreviewProvider {
//    static var previews: some View {
//        SecondView()
//    }
//}

import SwiftUI
import AVFoundation
import WatchKit

struct SecondView: View {
    @State private var isThirdViewPresented = false
    let audioPath = AVPlayer(url: Bundle.main.url(forResource: "flush", withExtension: "wav")!)
    @StateObject var audioPlayer = AudioPlayer()
    
    var body: some View {
        NavigationView {
            ZStack {
                ImageSequenceView2(imageNames2: getItem2())
                    .edgesIgnoringSafeArea(.all)
                
                NavigationLink(destination: ThirdView().navigationBarBackButtonHidden(true), isActive: $isThirdViewPresented) {
                    EmptyView()
                }
            }
            .onTapGesture {
                self.isThirdViewPresented = true
            }
        }
        .onAppear {
            DispatchQueue.main.async {
                self.playAudio()
                self.playHapticFeedback()
            }
        }
    }
    
    func getItem2() -> [String] {
        var imagesPath = ["fix mantep ekor bener_"]
        for i in 0..<389 {
            imagesPath.append("fix mantep ekor bener_\(String(format: "%05d", i))")
        }
        return imagesPath
    }
    
    func playAudio() {
        audioPath.play()
        Timer.scheduledTimer(withTimeInterval: 0.5 * Double(["mao"].count), repeats: false) { timer in
            self.audioPath.volume = 0
        }
    }
    
    func playHapticFeedback() {
        DispatchQueue.main.async {
            for i in 1...13 {
                if i >= 1 && i <= 5 {
                    WKInterfaceDevice.current().play(.start)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        WKInterfaceDevice.current().play(.stop)
                    }
                } else if i >= 9 {
                    WKInterfaceDevice.current().play(.start)
                }
                Thread.sleep(forTimeInterval: 1)
            }
        }
    }
}

struct ImageSequenceView2: View {
    var imageNames2: [String]
    @State private var currentIndex2 = 0
    
    var body: some View {
        Image(imageNames2[currentIndex2])
            .resizable()
            .scaledToFill()
            .edgesIgnoringSafeArea(.all)
            .onAppear {
                Timer.scheduledTimer(withTimeInterval: 0.033, repeats: true) { timer in
                    currentIndex2 = (currentIndex2 + 1) % imageNames2.count
                }
            }
    }
}

struct SecondView_Previews: PreviewProvider {
    static var previews: some View {
        SecondView()
    }
}
