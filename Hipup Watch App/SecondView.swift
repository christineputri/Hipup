//
//  SecondView.swift
//  Hipup Watch App
//
//  Created by Christine Putri on 29/04/24.
//


import SwiftUI
import AVFoundation
import WatchKit

struct SecondView: View {
    @State private var isThirdViewPresented = false

    let audioPath = AVPlayer(url: Bundle.main.url(forResource: "flush", withExtension: "wav")!)
    @StateObject var audioPlayer = AudioPlayer()
    @State var seconds: Int = 0
    @State var isHaptic = false
    @State var kondisiNafas: String = "breathin"
    @State var timer: Timer?
    @State var stop:Bool = false

    var body: some View {
        NavigationView {
            ZStack {
                ImageSequenceView2(imageNames2: getItem2())
                    .edgesIgnoringSafeArea(.all)

                NavigationLink(destination: ThirdView(timer: $timer).navigationBarBackButtonHidden(true), isActive: $isThirdViewPresented) {
                    EmptyView()
                }.buttonStyle(PlainButtonStyle()) // Hide the navigation link button
            }
            .onTapGesture {
                print("stop dong")
                stop = true
                timer?.invalidate()
                timer = nil
                self.isThirdViewPresented = true
            }
        }
        .onAppear {
            startTimer()
        }
        .onDisappear {
            stop = true
            timer?.invalidate()
            timer = nil

        }
        .onChange(of: seconds) { oldValue, newValue in

            print(seconds, kondisiNafas)

            if kondisiNafas == "breathin" {
                if (seconds == 5) {
                    kondisiNafas = "hold"
                    seconds = 1
                    WKInterfaceDevice.current().play(.start)
                }
            } else if kondisiNafas == "hold" {
                if (seconds == 3) {
                    kondisiNafas = "breathout"
                    seconds = 1
                    WKInterfaceDevice.current().play(.stop)
//                    audioPath.pause()
                }
            } else if kondisiNafas == "breathout" {
                if (seconds == 6) {
                    kondisiNafas = "breathin"
                    seconds = 1
                    WKInterfaceDevice.current().play(.start)
//                    audioPath.play()
                }
            }
        }
    }

    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
//            self.audioPath.volume = 0
//            audioPath.play()
//            WKInterfaceDevice.current().play(.start)
            if !stop {
                seconds += 1
            }
        }
//        timer?.fire()
    }

    func getItem2() -> [String] {
        var imagesPath: [String] = []
        for i in 0..<359 {
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
