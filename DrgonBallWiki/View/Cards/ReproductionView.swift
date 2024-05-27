//
//  ReproductionView.swift
//  DrgonBollWiki
//
//  Created by Esteban Perez Castillejo on 21/3/24.
//

import SwiftUI

struct ReproductionView: View {

    @Bindable var audioViewModel: DetailAudioViewModel
    @Binding var mostrarButton: Bool
    @Namespace var winAnimation

    private var audioStatusBar: some View {
        VStack {
            SliderView(
                value: $audioViewModel.currentTime,
                range: 0...audioViewModel.totalTime,
                onEditingChanged: audioViewModel.sliderEditingChanged
            )

            HStack {
                Text(audioViewModel.timeString(time: audioViewModel.currentTime))
                Spacer()
                Text(audioViewModel.timeString(time: audioViewModel.totalTime))
            }
            .font(.caption)
        }
    }
    
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

                Image(audioViewModel.cover)
                    .resizable()
                    .frame(width: 300, height: 300)
                    .padding(4)

                Text(audioViewModel.title)
                    .font(.custom("SaiyanSans", size: 50)).bold()
                    .foregroundStyle(Color.yellow)
                    .blur(radius: 0)
                    .overlay(
                        Text(audioViewModel.title)
                            .font(.custom("SaiyanSans", size: 50)).bold()
                            .foregroundStyle(Color.red)
                            .offset(x: 3, y: 3)
                    )
                    .padding(.horizontal, 3)
                    .shadow(radius: 10)

                HStack{
                    Button {
                        audioViewModel.showStatus.toggle()
                        audioViewModel.tooglePlayback(for: audioViewModel.showStatus ? .play : .pause)
                    } label: {
                        Image(systemName: audioViewModel.showStatus ? "pause.fill" : "play.fill")
                            .shadow(radius: 8)
                            .symbolEffect(.bounce, value: audioViewModel.showStatus)
                            .font(.custom( "", size: 60))
                            .foregroundStyle(audioViewModel.showStatus ? Color.green : Color.primary)
                    }
                    .padding(.horizontal, -2)

                    Button {
                        audioViewModel.tooglePlayback(for: .stop)
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

                audioStatusBar
                    .padding(.horizontal, 30)
                    .padding(.bottom, 5)
            }
            .matchedGeometryEffect(id: "reproduction", in: winAnimation)
            .background {
                RoundedRectangle(cornerRadius: 15, style: .continuous)
                    .fill(.ultraThinMaterial)
            }
            .padding()
            .onReceive(Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()) { _ in
                audioViewModel.updateProgress()
            }
        } else {
            VStack {
                if mostrarButton {
                    HStack {
                        Button {
                            withAnimation(.spring( response: 0.5, dampingFraction: 0.8)) {
                                audioViewModel.tooglePlayback(for: .stop)
                                mostrarButton = false
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

                        VStack(spacing: 5) {
                            HStack {
                                Button {
                                    withAnimation(.spring( response: 0.5, dampingFraction: 0.8)){
                                        audioViewModel.mostrarButtonMnu = false
                                    }
                                } label: {
                                    Image(audioViewModel.cover)
                                        .resizable()
                                        .frame(width: 50, height: 50)
                                        .padding(4)
                                }

                                Spacer()

                                Text(audioViewModel.title)
                                    .modifier(StyleViewFont(size: 25, color: .red))
                                    .padding(.horizontal, 5)

                                Spacer()

                                Button {
                                    audioViewModel.showStatus.toggle()
                                    audioViewModel.tooglePlayback(for: audioViewModel.showStatus ? .play : .pause)
                                } label: {
                                    Image(systemName: audioViewModel.showStatus ? "pause.fill" : "play.fill")
                                        .shadow(radius: 8)
                                        .symbolEffect(.bounce, value: audioViewModel.showStatus)
                                        .font(.custom( "", size: 30))
                                        .foregroundStyle(audioViewModel.showStatus ? .green : .primary)
                                }
                                .padding(.horizontal, -2)

                                Button {
                                    audioViewModel.tooglePlayback(for: .stop)
                                } label: {
                                    Image(systemName: "stop.fill")
                                        .shadow(radius: 8)
                                        .symbolEffect(.bounce, value: audioViewModel.statusButtonStop)
                                        .font(.custom( "", size: 30))
                                        .foregroundStyle(audioViewModel.showStatus ? .red : .primary)

                                }
                                .padding(.horizontal, 5)
                            }

                            audioStatusBar
                                .padding(.trailing, 10)
                                .padding([.leading, .bottom], 5)
                        }
                        .onReceive(Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()) { _ in
                            audioViewModel.updateProgress()
                        }
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
    let detailAudioViewModel = DetailAudioViewModel(title: "Dagon Ball", cover: "DragonBall_CD")

    return ReproductionView(audioViewModel: detailAudioViewModel, mostrarButton: .constant(true))
}
