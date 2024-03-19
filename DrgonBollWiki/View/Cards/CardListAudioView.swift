//
//  CardListView.swift
//  DrgonBollWiki
//
//  Created by Esteban Perez Castillejo on 18/3/24.
//

import SwiftUI
import AVFAudio

struct CardListAudioView: View {
    
    @State var player: AVAudioPlayer?
    @State var viewModel = HomeViewModel()
    
    @State private var isModal = false
    
    var body: some View {
        NavigationStack{
            ZStack{
                
                VStack{
                    List {
                        ForEach(arrayOfSounds, id: \.id) { sound in
                            HStack{
                                Text(" \(sound.title)").padding()
                                    .onTapGesture {
                                        isModal = true
                                    }
                                Spacer()
                                Button(action: {
                                    viewModel.isPlaying.toggle()
                                    
                                    if  viewModel.isPlaying  {
                                        viewModel.playAudioMusic(sound.title)
                                        
                                    }else {
                                        viewModel.pauseAudio()
                                    }
                                    
                                }, label: {
                                    Text( viewModel.isPlaying ? "play" : "Pause")
                                })
                            }
//                            .sheet(isPresented: $isModal, content:{
//                                
//                                DetailAudioView(viewModel: viewModel, playList: sound )
//                            })
                        }
                    }
                    .listStyle(PlainListStyle())
                }
            }.sheet(isPresented: $isModal){
                
            }
            .navigationTitle("Lista de reproducciones")
        }
        
    }
}

#Preview {
    CardListAudioView()
}
