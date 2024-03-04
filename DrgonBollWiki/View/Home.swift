//
//  Home.swift
//  DrgonBollWiki
//
//  Created by Grupo de Estudio on 1/3/24.
//

import SwiftUI

struct Home: View {
    @State private var apiService = DragonballAPIService()
    @State private var characters: Characters?
    @State private var isLoading = false
    @State private var selectedCharacter: Character?
    
    
    @State var isShow: Int = 2
    @State var isShow2: Int = 1
    
    @State private var offset: CGFloat = 0
    @State private var scrollSpeed: CGFloat = 0
    
    let isPerson = ["Shenlong":"Dragon" , "Goku":"GokuPeque", "Mutenroy": "Mutenroy"]
    let timer = Timer.publish(every: 0.02, on: .main, in: .common).autoconnect()
    let defaultBackgroundImage = "Dragon"
    
    var body: some View {
        NavigationStack{
            ZStack{
                LinearGradient(gradient: Gradient(colors: [Color.red, Color.blue]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    .edgesIgnoringSafeArea(.all)
                Image("Dragon").resizable()
                    .scaledToFit()
                
                    .frame(width: 600, height: 800)
                    .opacity(0.6)
            
                
                if liveScrol(isShow2) {
                    if isLoading{
                        ProgressView()
                    }else if let characters = characters{
                        ScrollView(.horizontal){
                            HStack{
                                
                                ForEach(characters.items, id:\.id){ character in
                                    Card(character: character)
                                     .padding()
                                     
                                }.contextMenu(ContextMenu(menuItems: {
                                    Button(action: {
                                        // logica
                                    }, label: {
                                        Text("Guardar en favoritos")
                                        Image(systemName: "star.fill")
                                    })
                                    
                                    Button(action: {
                                        // logica
                                    }, label: {
                                        Text("Compartir")
                                        Image(systemName: "square.and.arrow.up")
                                    })
                                    
                                    Button(action: {
                                        // logica
                                    }, label: {
                                        Text("Copiar")
                                        Image(systemName: "doc.on.doc")
                                    })
                                 
                                }))
                              
                            }.scrollTargetLayout()
                            .padding(.horizontal)
                        } .scrollTargetBehavior(.viewAligned)
                        .padding(.horizontal, 100)
                    }else {
                        Text("No se encuentra el personaje")
                    }
                    
                }else if liveScrol(isShow) {
                    ScrollView{
                        VStack(spacing: 0){
                                ForEach(isPerson.sorted(by: {$0.key<$1.key}), id: \.key ){ (key, value) in
                                    VStack{
                                        ParallaxHeder{
                                            Image(value).resizable()
                                                .scaledToFit()
                                        }
                                        .frame(width: 200, height: 400)
                                        Text(key ).font(.title).bold()
                                            .backgroundStyle(Material.regular)
                                    }
                                }
                            }
                        .padding()
                        
                    }
                   
                }
                
                VStack{
                    Spacer()
                    HStack(alignment: .top){
                        Image("Boll7")
                            .resizable()
                            .frame(width: 500, height: 500)
                            .padding(.leading, -130)
                            .padding(.bottom, -300)
                            .shadow(radius: 8)
                        Spacer()
                    }
                }
            }
          
            .onAppear{
                isLoading = true
                Task{
                    do{
                        characters = try await apiService.getCharacters()
                        isLoading = false
                    }catch{
                        print("Error: \(error)")
                        isLoading = false
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .automatic) {
                    Menu{
                        Button(action: {
                            isShow = 2
                            isShow2 = 1
                        }) {
                            Text("Cambiar Scrol 1")
                            Image( "Boll7")
                                .resizable()
                                .frame(width: 10, height: 10)
                        }
                        
                        Button(action: {
                            isShow = 1
                            isShow2 = 2
                        }) {
                            Text("Cambiar Scrol 2")
                            
                            Image( "Dragon")
                                .resizable()
                                .frame(width: 10, height: 10)
                        }
                        
                        Button(action: {
                            // Acción del botón de la barra de herramientas
                        }) {
                            
                            //  Image(systemName: "person")
                            Text("item 3")
                            Image( "Mutenroy")
                                .resizable()
                                .frame(width: 10, height: 10)
                        }
                        Button(action: {
                            // Acción del botón de la barra de herramientas
                        }) {
                            Text("Imet 3")
                            Image( "GokuPeque")
                                .resizable()
                                .frame(width: 10, height: 10)
                        }
                        
                    } label: {
                        Image("logoGoku").resizable()
                            .frame(width: 40, height: 50)
                    }
                    
                    
                }
            }
            
        }
    }
    
    func liveScrol(_ index: Int) -> Bool {
        switch index {
        case 1:
            return true
        case 2:
            return false
        default:
            return false
        }
    }
}

#Preview {
    Home()
}
