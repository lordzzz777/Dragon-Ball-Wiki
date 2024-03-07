//
//  Card.swift
//  DrgonBollWiki
//
//  Created by Esteban Perez Castillejo on 3/3/24.
//

import SwiftUI
//import AVFoundation

struct Card: View {
    
    let character: Character
    var sound = ""
    @State private var isFlipped = false
    @State private var isOpaciti = true
    @State private var show = false
    var playCardSound: () -> Void //Recibiendo un closure como parametro para ejecutar el sonido cuando se gire la card
    
    //El closure debe ser con escape para que sea asíncrono y no bloquee la ejecución de la UI en el hilo principal (Lo sugirió Xcode)
    init(character: Character, playSound: @escaping () -> Void) {
        self.character = character
        self.playCardSound = playSound
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
            DetailsView(singleCharactersDataService: SingleCharacterDataService(), characterId: character.id)
        })
        .onTapGesture {
            withAnimation {
                isFlipped.toggle()
                
                isFlipped ? playCardSound() : playCardSound()
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

