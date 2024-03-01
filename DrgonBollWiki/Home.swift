//
//  Home.swift
//  DrgonBollWiki
//
//  Created by Grupo de Estudio on 1/3/24.
//

import SwiftUI

struct Home: View {


    let isPerson = ["Shenlong":"Dragon" , "Goku":"GokuPeque", "Mutenroy": "Mutenroy"]
    var body: some View {
        NavigationStack{
            ZStack{
                Image("Dragon").resizable()
                    .frame(width: 600, height: 800)
                    .opacity(0.3)
                
                ScrollView{
                    VStack{
                      
                            ForEach(1..<4) {_ in
                                Section{
                                    ForEach(isPerson.sorted(by: {$0.key<$1.key}), id: \.key ){ (key, value) in
                                        
                                        Image(value).resizable().frame(width: 40, height: 40)
                                        Text(key ).font(.title).bold()
                                    }
                                }
                            }.padding()
                        
                    }.padding()
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
            .toolbar {
                ToolbarItem(placement: .automatic) {
                    Menu{
                        Button(action: {
                            // Acción del botón de la barra de herramientas
                        }) {
                            Text("Imet 0")
                            Image( "Boll7")
                                .resizable()
                                .frame(width: 10, height: 10)
                        }
                        
                        Button(action: {
                            // Acción del botón de la barra de herramientas
                        }) {
                            Text("Imet 1")
                            Image( "Dragon")
                                .resizable()
                                .frame(width: 10, height: 10)
                        }
                        
                        Button(action: {
                            // Acción del botón de la barra de herramientas
                        }) {
                          //  Image(systemName: "person")
                            Text("Imet 2")
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
}

#Preview {
    Home()
}
