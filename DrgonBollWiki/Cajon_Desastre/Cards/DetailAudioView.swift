//
//  DetailAudioView.swift
//  DrgonBollWiki
//
//  Created by Esteban Perez Castillejo on 19/3/24.
//

import SwiftUI
import AVFAudio

struct DetailAudioView: View {
    @State var audioViewModel = DetailAudioViewModel()
    @Binding var title: String
    @State private var showStatus = false
    
    var body: some View {
        VStack{
            Text(title).font(.custom("SaiyanSans", size: 20)).bold()
            Spacer()
            Button(action: {
                showStatus.toggle()
                if showStatus == true {
                    audioViewModel.playAudio(title)
                   
                }else {
                    audioViewModel.pauseAudio()
                    
                }
            }, label: {
                
                Image(systemName: showStatus ? "pause.fill" : "play.fill").symbolEffect(.bounce, value: showStatus)
            }).padding()
            
      
        }
    }
}

#Preview {
   CardListAudioView()
}
