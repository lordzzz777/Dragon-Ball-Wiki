//
//  CardListView.swift
//  DrgonBollWiki
//
//  Created by Esteban Perez Castillejo on 18/3/24.
//

import SwiftUI
import AVFAudio

struct CardListAudioView: View {
    
    @State private var viewModel = CardListAudioViewModel()
    @State private var audioL = ""
    @State private var covers = ""
    @State private var showModal = false
    @State private var showWinAudio = false
    @State var mostrarButton = false
    
    @Namespace var winAnimation
    
    var body: some View {
        NavigationStack{
            ZStack{
            
                VStack{
                  
                    List {
                        VStack(alignment: .leading){
                            ForEach(viewModel.arrayOfSounds, id: \.self) { sound in
                                Text(sound.title).font(.custom("SaiyanSans", size: 29))
                                    .foregroundStyle(Color.orange)
                                    .shadow(color: .red, radius: 10, x: 5, y: 5)
                                    .padding()
                                    .onTapGesture {
                                    audioL = sound.title
                                    covers = sound.imageCoves
                                    // showModal = true
                                    mostrarButton = true
                                    withAnimation(.spring( response: 0.5, dampingFraction: 0.8)){
                                        showWinAudio = true
                                    }
                                }
                                
                            }
                        }.listRowBackground(Color.clear)
                            .background(Color.black.opacity(0.5))
                                .cornerRadius(14)
                                .opacity(0.9)
                                .padding(3)
                                .frame(width: 300, height: 400, alignment: .center)
                    }
                    
                    .listStyle(PlainListStyle())
                }
                if showWinAudio{
                    ReproductionView(mostrarButton: $mostrarButton, title: $audioL, cover: $covers)
                        .padding(.top, -9)
                }
            }
           
//            .sheet(isPresented: $showModal){
//                DetailAudioView(title: $audioL, cover: $covers)
//            }
           
        }
        
    }
}

#Preview {
    CardListAudioView()
}
