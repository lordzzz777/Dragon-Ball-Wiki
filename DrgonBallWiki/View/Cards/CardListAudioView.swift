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
    @State private var showWinAudio = false
    @State var mostrarButton = false
    @Binding var showListAudio: Bool
    @Namespace var winAnimation

    var body: some View {
        NavigationStack {
            VStack {
                List {
                    VStack(alignment: .leading) {
                        HStack(alignment: .firstTextBaseline) {
                            Spacer()
                            Text("Lista de reproducciones")
                                .modifier(StyleViewFont(size: 30, color: .red))
                                .shadow(color: .cyan, radius: 5)

                            Spacer()

                            Button {
                                withAnimation(.spring(response: 0.3, dampingFraction: 1)) {
                                    showListAudio = false
                                }
                            } label: {
                                Image(systemName: "xmark")
                                    .font(.footnote)
                                    .fontWeight(.semibold)
                                    .foregroundStyle(Color.white)
                                    .padding(7)
                                    .background {
                                        RoundedRectangle(cornerRadius: 100)
                                            .fill(.ultraThinMaterial)
                                    }
                            }
                        }
                        .padding()

                        Divider()

                        ForEach(viewModel.arrayOfSounds, id: \.self) { sound in
                            Text(sound.title)
                                .modifier(StyleViewFont(size: 30, color: .red))
                                .padding()
                                .onTapGesture {
                                    audioL = sound.title
                                    covers = sound.imageCoves

                                    mostrarButton = false

                                    withAnimation(.spring( response: 0.5, dampingFraction: 0.8)){
                                        showWinAudio = true
                                        mostrarButton = true
                                    }
                                }

                        }
                    }
                    .listRowBackground(Color.clear)
                    .listRowSeparator(.hidden)
                    .background {
                        RoundedRectangle(cornerRadius: 15, style: .continuous)
                            .fill(.ultraThinMaterial)
                    }

                }
                .listStyle(.plain)
                .padding(.top, 120)
            }
            .overlay {
                if showWinAudio {
                    let audioViewModel = DetailAudioViewModel(title: audioL, cover: covers)

                    ReproductionView(audioViewModel: audioViewModel, mostrarButton: $mostrarButton)
                        .padding(.horizontal, 5)
                        .onChange(of: mostrarButton) {
                            if !mostrarButton {
                                audioViewModel.tooglePlayback(for: .stop)
                            }
                        }
                }
            }
        }

    }
}

#Preview {
    CardListAudioView(showListAudio: .constant(false))
}
