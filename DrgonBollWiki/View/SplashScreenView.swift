//
//  SplashScreenView.swift
//  DrgonBollWiki
//
//  Created by Jacob Aguilar on 11-03-24.
//

import SwiftUI

struct SplashScreenView: View {
    var body: some View {
        VStack(spacing: 0) {
            Text("Q.E.P.D")
                .font(.title)
            
            Image("toriyamagoku")
                .resizable()
                .padding(.top, 65)
                .aspectRatio(contentMode: .fit)
                .frame(height: 400)
                .clipShape(Circle())
            
            Text("Akira Toriyama 1955 - 2024")
                .font(.title2)
            
            Text("Muchas gracias por las enseñanzas y valores que nos entregaste a través de tu arte")
                .padding(.top, 40)
        }
        .padding(.horizontal, 10)
        .fontWeight(.bold)
        .fontDesign(.rounded)
        .foregroundStyle(Color.white)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black)
    }
}

#Preview {
    SplashScreenView()
}
