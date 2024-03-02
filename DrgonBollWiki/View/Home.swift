//
//  Home.swift
//  DrgonBollWiki
//
//  Created by Grupo de Estudio on 1/3/24.
//

import SwiftUI

struct Home: View {

    @State var isShow: Int = 2
    @State var isShow2: Int = 1

    @State private var offset: CGFloat = 0
    @State private var scrollSpeed: CGFloat = 0
    
    let isPerson = ["Shenlong":"Dragon" , "Goku":"GokuPeque", "Mutenroy": "Mutenroy"]
    let timer = Timer.publish(every: 0.02, on: .main, in: .common).autoconnect()
    var body: some View {
        NavigationStack{
            ZStack{
                Image("Dragon").resizable()
                    .scaledToFit()
                
                    .frame(width: 600, height: 800)
                    .opacity(0.3)
                
                if liveScrol(isShow) {
                    ScrollView(.horizontal) {
                        HStack {
                            ForEach(1..<4) { _ in
                                Section {
                                    ForEach(isPerson.sorted(by: { $0.key < $1.key }), id: \.key) { (key, value) in
                                        VStack {
                                            ParallaxHeder {
                                                Image(value).resizable().scaledToFit()
                                            }
                                            .frame(width: 200, height: 400)
                                            Text(key).font(.title).bold()
                                        }
                                    }
                                    
                                }
                                .padding(.vertical, 100)
                            }
                        }
                    }
                    
                }else if liveScrol(isShow2) {
                    ScrollView{
                        ForEach(1..<4) {_ in
                            Section{
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
                        }.padding()
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
