//
//  ReproductionView.swift
//  DrgonBollWiki
//
//  Created by Esteban Perez Castillejo on 21/3/24.
//

import SwiftUI

struct ReproductionView: View {

    @State var audioViewModel: DetailAudioViewModel

    @Binding var mostrarButton: Bool
    @Binding var title: String
    @Binding var cover: String

    @Namespace var winAnimation

    var body: some View {
        if !audioViewModel.mostrarButtonMnu {
            VStack {
                HStack {
                    Button {
                        withAnimation(.spring( response: 0.5, dampingFraction: 0.8)) {
                            audioViewModel.mostrarButtonMnu = true
                        }
                    } label: {
                        Image(systemName: "arrow.up.backward.and.arrow.down.forward")
                            .symbolEffect(.bounce, value:  audioViewModel.mostrarButtonMnu)
                            .font(.footnote)
                            .fontWeight(.semibold)
                            .foregroundStyle(Color.white)
                            .padding(7)
                            .background {
                                RoundedRectangle(cornerRadius: 300)
                                    .fill(.ultraThinMaterial)
                            }
                    }
                    .padding()

                    Spacer()
                }

                Image(cover)
                    .resizable()
                    .frame(width: 300, height: 300)
                    .padding(4)

                Text(title)
                    .font(.custom("SaiyanSans", size: 50)).bold()
                    .foregroundStyle(Color.yellow)
                    .blur(radius: 0)
                    .overlay(
                        Text(title)
                            .font(.custom("SaiyanSans", size: 50)).bold()
                            .foregroundStyle(Color.red)
                            .offset(x: 3, y: 3)
                    )
                    .padding(.horizontal, 3)
                    .shadow(radius: 10)

                HStack{
                    Button {
                        audioViewModel.showStatus.toggle()
                        audioViewModel.tooglePlayback(for: audioViewModel.showStatus ? .play : .pause, title: title)
                    } label: {
                        Image(systemName: audioViewModel.showStatus ? "pause.fill" : "play.fill")
                            .shadow(radius: 8)
                            .symbolEffect(.bounce, value: audioViewModel.showStatus)
                            .font(.custom( "", size: 60))
                            .foregroundStyle(audioViewModel.showStatus ? Color.green : Color.primary)
                    }
                    .padding(.horizontal, -2)

                    Button {
                        audioViewModel.showStatus = false
                        audioViewModel.tooglePlayback(for:  .stop, title: title)
                    } label: {
                        Image(systemName: "stop.fill")
                            .shadow(radius: 8)
                            .symbolEffect(.bounce, value: audioViewModel.statusButtonStop)
                            .font(.custom( "", size: 60))
                            .foregroundStyle(audioViewModel.showStatus ? Color.red : Color.primary)

                    }
                    .padding(.horizontal, 5)
                }
                .padding()
            }
            .matchedGeometryEffect(id: "reproduction", in: winAnimation)
            .background{
                RoundedRectangle(cornerRadius: 15, style: .continuous)
                    .fill(.ultraThinMaterial)
            }
            .padding()

        } else {
            VStack {
                if mostrarButton {
                    HStack {
                        Button {
                            withAnimation(.spring( response: 0.5, dampingFraction: 0.8)) {
                                audioViewModel.tooglePlayback(for: .stop, title: title)
                                mostrarButton = false
                                audioViewModel.showStatus = false
                            }
                        } label: {
                            Image(systemName: "xmark")
                                .font(.footnote)
                                .fontWeight(.semibold)
                                .foregroundStyle(Color.white)
                                .padding(7)

                                .background{
                                    RoundedRectangle(cornerRadius: 100)
                                        .fill(.ultraThinMaterial)
                                }
                                .padding(9)
                        }

                        Button {
                            withAnimation(.spring( response: 0.5, dampingFraction: 0.8)){
                                audioViewModel.mostrarButtonMnu = false
                            }
                        } label: {
                            Image(cover)
                                .resizable()
                                .frame(width: 50, height: 50)
                                .padding(4)
                        }

                        Spacer()

                        Text(title)
                            .modifier(StyleViewFont(size: 25, color: .red))
                            .padding(.horizontal, 5)

                        Spacer()

                        Button {
                            audioViewModel.showStatus.toggle()
                            audioViewModel.tooglePlayback(for: audioViewModel.showStatus ? .play : .pause, title: title)
                        } label: {
                            Image(systemName: audioViewModel.showStatus ? "pause.fill" : "play.fill")
                                .shadow(radius: 8)
                                .symbolEffect(.bounce, value: audioViewModel.showStatus)
                                .font(.custom( "", size: 30))
                                .foregroundStyle(audioViewModel.showStatus ? Color.green : Color.primary)
                        }
                        .padding(.horizontal, -2)

                        Button {
                            audioViewModel.showStatus = false
                            audioViewModel.tooglePlayback(for:  .stop, title: title)
                        } label: {
                            Image(systemName: "stop.fill")
                                .shadow(radius: 8)
                                .symbolEffect(.bounce, value: audioViewModel.statusButtonStop)
                                .font(.custom( "", size: 30))
                                .foregroundStyle(audioViewModel.showStatus ? Color.red : Color.primary)

                        }
                        .padding(.horizontal, 5)

                    }
                    .matchedGeometryEffect(id: "reproduction", in: winAnimation)
                    .background {
                        RoundedRectangle(cornerRadius: 15, style: .continuous)
                            .fill(.ultraThinMaterial)
                    }
                    .padding()

                    Spacer()
                }
            }
        }
    }
}

#Preview {
    let detailAudioViewModel = DetailAudioViewModel()

    return ReproductionView(audioViewModel: detailAudioViewModel, mostrarButton: .constant(true), title: .constant("Dagon Ball") , cover: .constant("DragonBall_CD"))
}
