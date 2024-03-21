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
    @State private var showModal = false
    var body: some View {
        NavigationStack{
            ZStack{
                
                VStack{
                    List {
                        ForEach(viewModel.arrayOfSounds, id: \.self) { sound in
                            Text(sound.title).onTapGesture {
                                audioL = sound.title
                                showModal = true
                            }
                        }
                        
                    }
                    .listStyle(PlainListStyle())
                }
            }
            .sheet(isPresented: $showModal){
                DetailAudioView(title: $audioL)
            }
            .navigationTitle("Lista de reproducciones")
        }
        
    }
}

#Preview {
    CardListAudioView()
}
