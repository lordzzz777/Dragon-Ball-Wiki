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
    @Binding var showListAudio: Bool
    @Namespace var winAnimation
    
    var body: some View {
        NavigationStack{
            VStack{
                List {
                    VStack(alignment: .leading){
                        
                        HStack(alignment: .firstTextBaseline){
                            Spacer()
                            Text("Lista de reproducciones")
                                .modifier(StyleViewFont(size: 30, color: .red))
                                .shadow(color: .cyan, radius: 5)
                            Spacer()
                            Button(action: {
                                withAnimation(.spring(response: 0.3, dampingFraction: 1)) {
                                    showListAudio = false
                                }
                            }, label: {
                                Image(systemName: "xmark")
                                    .font(.footnote)
                                    .fontWeight(.semibold)
                                    .foregroundStyle(Color.white)
                                    .padding(7)
                                    .background {
                                        RoundedRectangle(cornerRadius: 100)
                                            .fill(.ultraThinMaterial)
                                    }.padding()
                            })
                        }
                        Divider()
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
                        
                }.listStyle(PlainListStyle())
                    .padding(.top,120)
            }.overlay{
                if showWinAudio{
                    ReproductionView(mostrarButton: $mostrarButton, title: $audioL, cover: $covers)
                        .padding(.top, 30)
                }
                
            }
        }
        
    }
}

#Preview {
    CardListAudioView(showListAudio: .constant(false))
}
