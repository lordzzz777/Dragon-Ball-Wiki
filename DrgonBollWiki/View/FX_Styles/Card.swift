//
//  Card.swift
//  DrgonBollWiki
//
//  Created by Esteban Perez Castillejo on 3/3/24.
//

import SwiftUI
import AVFoundation

struct Card: View {
    let character: Character
    @State private var isFlipped = false
    @State private var isOpaciti = true
    @State private var show = false
    /// Decta una intacia de `AVAudioPlayer`
    var  audioPlayer: AVAudioPlayer?
    
    init(character: Character) {
        self.character = character
        
        /// ## Cargar el Archivo de Audioo
        if let soundURL = Bundle.main.path(forResource: "cardFx", ofType: "mp3") {
            
            do{
                self.audioPlayer = try AVAudioPlayer(contentsOf: URL(filePath: soundURL))
                print("reproducir \(soundURL)")
            }catch {
                print("Error al cargar el archivo de audio: -> ", error.localizedDescription)
            }
        }else {
           print("No se pudo cargar el archivo de audio")
        }
    }
    
    
    var body: some View {
        
        VStack {
            if !isFlipped {
                AsyncImage(url: URL(string: character.image)) { image in
                    image.resizable()
                        .aspectRatio(contentMode: .fit)
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 400, height: 400)
                .cornerRadius(10)
                .padding(.bottom, 10)
                
                Text(character.name)
                    .font(.title).bold()
            } 
        }
        .frame(width: 300, height: 460)
        .padding()
        .background(isFlipped && isOpaciti ?  Color.white.opacity(0.8) : Color.clear )
        .border(isFlipped && isOpaciti ? Color.black : Color.clear, width: 3)
        .cornerRadius(20)
        .shadow(radius: 5)
        .rotation3DEffect(
            .degrees(isFlipped ? 180 : 0),
            axis: (x: 0.0, y: 1.0, z: 0.0)
        )
        .overlay{
            if isFlipped  {
                ScrollView(showsIndicators: false){
                    VStack{
                        HStack{
                            Image("Boll7")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 30, height: 30).padding(.top, 24)
                            Text(character.name).font(.title).bold().padding(.top, 20)
                        
                            Button(action: {
                                show = true
                            }, label: {
                                Text("Saber mas")
                            }).padding(.top, 20)
                        }
                        Text(character.description)
                            .font(.body)
                            .frame(width: 270)
                            .padding(5)
                       
                    }
                }
            }
        }.sheet(isPresented: $show, content: {
            DetailsView(characterId: character.id)
        })
        .onTapGesture {
            withAnimation {
                isFlipped.toggle()
                
                if isFlipped {
                    audioPlayer?.play()
                }
            }
        }
    }
}


// Vista auxiliar para aplicar el efecto de desenfoque
struct BlurView: UIViewRepresentable {
    let style: UIBlurEffect.Style
    
    func makeUIView(context: Context) -> UIVisualEffectView {
        UIVisualEffectView(effect: UIBlurEffect(style: style))
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {}
}

