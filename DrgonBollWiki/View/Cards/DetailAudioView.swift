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
    @Binding var cover: String
    
    @State private var showStatus = false
    @State private var statusButtonStop = false
   
    
    var body: some View {
        ZStack{
            Image("maxresdefault2").resizable()
                .scaledToFit()
                .frame(width: 3000, height: 800)
                .opacity(0.6)
                .padding()
                .padding(.leading, 70)
                .modifier(StyleColorDegrader(isColor: .blue, isColor2: .yellow))
            VStack{
                
                Image(cover)
                    .resizable()
                    .frame(width: 300, height: 300)
                    .shadow(radius: 10)
                    .padding(.top, -10)
                ZStack{
//                    Image("Ball1")
//                        .resizable()
//                        .frame(width: 180, height: 180)
//                        .padding(.leading, 30)
//                        .padding(.top, -30)
//                        .shadow(radius: 10)
                    Text(title)
                        .font(.custom("SaiyanSans", size: 60)).bold()
                        .foregroundStyle(Color.yellow)
                        .blur(radius: 0)
                        .overlay(
                            Text(title)
                                .font(.custom("SaiyanSans", size: 60)).bold()
                                .foregroundStyle(Color.red)
                                .offset(x: 5, y: 5)
                            
                        )
                        .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                }
                HStack{
                    Button(action: {
                        showStatus.toggle()
                        audioViewModel.tooglePlayback(for: showStatus == true ? .play : .pause, title: title)
                    }, label: {
                        
                        Image(systemName: showStatus ? "pause.fill" : "play.fill")
                            .shadow(radius: 8)
                            .symbolEffect(.bounce, value: showStatus)
                            .font(.custom( "", size: 60))
                            .foregroundStyle(showStatus ? Color.green : Color.gray)
                    }).padding()
                    
                    Button(action: {
                        showStatus = false
                        audioViewModel.tooglePlayback(for:  .stop, title: title)
                    }, label: {
                        
                        Image(systemName: "stop.fill")
                            .shadow(radius: 8)
                            .symbolEffect(.bounce, value: statusButtonStop)
                            .font(.custom( "", size: 60))
                            .foregroundStyle(showStatus ? Color.red : Color.gray)
                        
                    }).padding()
                    
                }.background(Color.black).cornerRadius(10.0).opacity(0.7)
                    .padding(.top, 200)
                
            }
            
        }
    }
}

#Preview {
    
    
    DetailAudioView(title: .constant("Dagon Ball"), cover: .constant("DragonBall_CD"))
   // CardListAudioView()
}
