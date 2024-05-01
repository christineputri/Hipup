////
////  First.swift
////  Hipup Watch App
////
////  Created by Christine Putri on 29/04/24.
////
//
//import SwiftUI
//
//struct FirstView: View {
//    @State private var isSecondViewPresented = false
//    
//    var body: some View {
//        NavigationView {
//            ZStack {
//                ImageSequenceView1(imageNames1: getItem1())
//                    .edgesIgnoringSafeArea(.all)
//                
//                NavigationLink(destination: SecondView().navigationBarBackButtonHidden(true), isActive: $isSecondViewPresented) {
//                    EmptyView()
//                }
//            }
//            .onTapGesture {
//                self.isSecondViewPresented = true
//            }
//        }
//    }
//    
//    func getItem1() -> [String] {
//        var imagesPath: [String] = []
//        for i in 0..<89 {
//            imagesPath.append("Gestrue_Tangan_Fix_\(String(format: "%05d", i))")
//        }
//        return imagesPath
//    }
//}
//
//struct ImageSequenceView1: View {
//    var imageNames1: [String]
//    @State private var currentIndex1 = 0
//    
//    var body: some View {
//        Image(imageNames1[currentIndex1])
//            .resizable()
//            .scaledToFill()
//            .edgesIgnoringSafeArea(.all)
//            .onAppear {
//                Timer.scheduledTimer(withTimeInterval: 0.033, repeats: true) { timer in
//                    currentIndex1 = (currentIndex1 + 1) % imageNames1.count
//                }
//            }
//    }
//}
//
//struct FirstView_Previews: PreviewProvider {
//    static var previews: some View {
//        FirstView()
//    }
//}



import SwiftUI

struct FirstView: View {
    @State private var isSecondViewPresented = false
    
    var body: some View {
        NavigationView {
            ZStack {
                ImageSequenceView1(imageNames1: getItem1())
                    .edgesIgnoringSafeArea(.all)
            }
            .navigationBarHidden(true) // Hide the navigation bar
            .onTapGesture {
                self.isSecondViewPresented = true
            }
            .sheet(isPresented: $isSecondViewPresented) {
                SecondView()
            }
        }
    }
    
    func getItem1() -> [String] {
        var imagesPath: [String] = []
        for i in 0..<89 {
            imagesPath.append("Gestrue_Tangan_Fix_\(String(format: "%05d", i))")
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
            .scaledToFill()
            .edgesIgnoringSafeArea(.all)
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
