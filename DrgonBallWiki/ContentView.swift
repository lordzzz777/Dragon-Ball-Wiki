//
//  ContentView.swift
//  DrgonBollWiki
//
//  Created by Grupo de Estudio on 1/3/24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var isSplashScreenFinish: Bool = false
    @State private var animation: Bool = false
    var shape: any Shape {
        animation ? Circle() : Rectangle()
    }
    
    var body: some View {
        ZStack {
            SplashScreenView()
                .offset(x: 0, y: animation ? -1400 : 0)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            Home()
                .offset(x: 0, y: animation ? 0 : 1400)
        }
        .ignoresSafeArea()
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                withAnimation(.easeInOut(duration: 1)) {
                    animation = true
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
