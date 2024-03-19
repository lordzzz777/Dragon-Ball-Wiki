//
//  CardListAudio.swift
//  DrgonBollWiki
//
//  Created by Esteban Perez Castillejo on 18/3/24.
//

import SwiftUI

struct CardListAudio: View {
    @State var audioViewModel = AudioViewModel()
    var body: some View {
        NavigationStack{
            List(audioViewModel.audioPlayerMusic.keys.sorted(by: {$0.title<$1.title}), id: \.self) { playlist in
                Text(playlist.title.description)
                           Button(action: {
                               // Lógica para reproducir la lista de reproducción seleccionada
                               // Por ejemplo, podrías tener una función en tu ViewModel para reproducir la lista seleccionada
                               // audioViewModel.play(playlist)
                           }) {
                               Text(playlist.title)
                           }
                       }
        }
    }
}

#Preview {
    CardListAudio()
}
