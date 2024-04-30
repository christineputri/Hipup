//
//  FirstView.swift
//  Hipup Watch App
//
//  Created by Christine Putri on 29/04/24.
//

import SwiftUI

struct FirstView: View {
    @State private var isSecondViewPresented = false
    
    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    Image("album")
                        .resizable()
                        .scaledToFill()
                        .edgesIgnoringSafeArea(.all)
                    Image("dadu")
                        .resizable()
                        .scaledToFill()
                        .edgesIgnoringSafeArea(.all)
                    ImageSequenceView1(imageNames1: getItem1())
                        .padding()
                }
                
                .onTapGesture {
                    self.isSecondViewPresented = true
                }
                .fullScreenCover(isPresented: $isSecondViewPresented, content: {
                    SecondView().navigationBarBackButtonHidden(true)
                })
                
                NavigationLink(destination: SecondView().navigationBarBackButtonHidden(true)) {
                    EmptyView()
                }
            }
        }
    }
    
    func getItem1() -> [String] {
        var imagesPath = ["hipup_pngsequence_page1_"]
        for i in 0..<3 {
            imagesPath.append("hipup_pngsequence_page1_\(String(format: "%05d", i))")
        }
        return imagesPath
    }
}

struct ImageSequenceView1: View {
    var imageNames1: [String]
    @State private var currentIndex1 = 0
    
    var body: some View {
        Image(imageNames1[currentIndex1])
            .resizable()
            .scaledToFit()
            .onAppear {
                Timer.scheduledTimer(withTimeInterval: 0.033, repeats: true) { timer in
                    currentIndex1 = (currentIndex1 + 1) % imageNames1.count
                }
            }
    }
}

struct FirstView_Previews: PreviewProvider {
    static var previews: some View {
        FirstView()
    }
}
