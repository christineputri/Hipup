//
//  SecondView.swift
//  Hipup Watch App
//
//  Created by Christine Putri on 29/04/24.
//

import SwiftUI

struct SecondView: View {
    @State private var isThirdViewPresented = false
    
    var body: some View {
        NavigationView {
            VStack {
//                ImageSequenceView2(imageNames2: getItem2())
//                    .padding()
                ZStack {
//                    Image("langit")
//                        .resizable()
//                        .scaledToFill()
//                        .edgesIgnoringSafeArea(.all)
//                    Image("rumput")
//                        .resizable()
//                        .scaledToFill()
//                        .edgesIgnoringSafeArea(.all)
                    ImageSequenceView2(imageNames2: getItem2())
                        .padding()
                }
                
                .onTapGesture {
                    self.isThirdViewPresented = true
                }
                .fullScreenCover(isPresented: $isThirdViewPresented, content: {
                    ThirdView().navigationBarBackButtonHidden(true)
                })
                
                NavigationLink(destination: ThirdView().navigationBarBackButtonHidden(true)) {
                    EmptyView()
                }
            }
        }
    }
    
    func getItem2() -> [String] {
        var imagesPath = ["fix mantep ekor bener_"]
        for i in 0..<390 {
            imagesPath.append("fix mantep ekor bener_\(String(format: "%05d", i))")
        }
        return imagesPath
    }
}

struct ImageSequenceView2: View {
    var imageNames2: [String]
    @State private var currentIndex2 = 0
    
    var body: some View {
        Image(imageNames2[currentIndex2])
            .resizable()
            .scaledToFit()
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
