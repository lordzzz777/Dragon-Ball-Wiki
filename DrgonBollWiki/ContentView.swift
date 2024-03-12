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
    
    var body: some View {
        ZStack {
            Home(allCaractersDataService: AllCharactersDataService(), planetsDataSevice: PlanetsDataService(), dbSwiftDataModel: [], dbSwiftDataViewModel: DbSwiftDataViewModel())
            
            SplashScreenView()
                .cornerRadius(animation ? 400 : 30)
//                .animation(.easeIn, value: 0.8)
                .scaleEffect(animation ? 0 : 1)
                .offset(x: 0, y: animation ? 400 : 0)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .ignoresSafeArea()
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                withAnimation(.spring(response: 1, dampingFraction: 0.9)) {
                    animation = true
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
