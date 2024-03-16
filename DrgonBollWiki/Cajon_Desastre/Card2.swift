//
//  Card2.swift
//  DrgonBollWiki
//
//  Created by Esteban Perez Castillejo on 13/3/24.
//

import SwiftUI
//import AVFoundation

struct Card2: View {
    
    let character: Character
    var sound = ""
    @Namespace var animation
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
          
            ZStack{
                
                AsyncImage(url: URL(string: character.image)) { image in
                    image.resizable()
                        .aspectRatio(contentMode: .fit)
                } placeholder: {
                    ProgressView()
                }.shadow(color: .yellow, radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                    .matchedGeometryEffect(id: "image\(character.id)", in: animation)
                .frame(width: 320, height: 320)
                .cornerRadius(10)
                .padding(.bottom, 10)
               

                Text(character.name)
                    .font(.custom("SaiyanSans", size: 42)).bold().padding(.top, 175).padding(.horizontal, -110)
                    .rotationEffect(Angle(degrees: -90.0)).foregroundStyle(.white).shadow(color: .purple, radius: 5 )
            }.opacity(isFlipped ? 0 : 1)
        }
        .frame(width: 250, height: 400)
        .cornerRadius(20)
        .frame(width: 300, height: 460)
        .padding()
        .rotation3DEffect(
            .degrees(isFlipped ? 180 : 0),
            axis: (x: 0.0, y: 1.0, z: 0.0)
        )
        .overlay{
            if isFlipped  {
                ScrollView(showsIndicators: false){
                    VStack{
                        HStack{
                        
                            AsyncImage(url: URL(string: character.image)) { image in
                                image.resizable()
                                    .aspectRatio(contentMode: .fit)
                            } placeholder: {
                                ProgressView()
                            }.shadow(color: .yellow, radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                                .matchedGeometryEffect(id: "image\(character.id)", in: animation)
                                .frame(width: 100, height: 100).padding(.top, 24)
                                
                            Text(character.name).font(.custom("SaiyanSans", size: 30)).bold().padding(.top, 20)
                               
                            Button(action: {
                                show = true
                            }, label: {
                                Text("SaiyanSans")
                            }).padding(.top, 20)
                        }
                        Text(character.description)
                            .font(.body)
                            .frame(width: 270)
                            .padding(5)
                       
                    }
                }.padding(15)
                    .background(.bar, in: .rect(cornerRadius: 10))
                    .padding( 15)
               
            }
        }.sheet(isPresented: $show, content: {
            DetailsView(selectedCharacter: character)
        })
        .onTapGesture {
            withAnimation(.interactiveSpring(response: 1)) {
                isFlipped.toggle()
                
                isFlipped ? playCardSound() : playCardSound()
            }
        }
    }
}

struct ColorView2: View {
    
    var color: Color
    
    var body: some View {
        Rectangle()
            .fill(color.gradient)
            .frame(width: 270, height: 400)
            .cornerRadius(20)
    }
}
