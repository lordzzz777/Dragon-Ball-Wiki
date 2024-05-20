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
                    HStack{
                        
                        Spacer()
                    }
                    List {
                        VStack(alignment: .leading){
                            ForEach(viewModel.arrayOfSounds, id: \.self) { sound in
                                Text(sound.title)
                                    .modifier(StyleViewFont(size: 30, color: .red))
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
                            .background{
                                RoundedRectangle(cornerRadius: 15, style: .continuous)
                                    .fill(.ultraThinMaterial)
                            }
                                .frame(width: 300, height: 400, alignment: .center)
                    }
                    
                    .listStyle(PlainListStyle())
                }
                if showWinAudio{
                    ReproductionView(mostrarButton: $mostrarButton, title: $audioL, cover: $covers)
                        .padding(.top, -30)
                }
            }

        }
        
    }
}

#Preview {
    CardListAudioView()
}
