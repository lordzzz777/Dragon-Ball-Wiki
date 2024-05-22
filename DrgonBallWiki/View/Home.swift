//
//  Home.swift
//  DrgonBollWiki
//
//  Created by Grupo de Estudio on 1/3/24.
//

import SwiftUI

struct Home: View {
    
    // MARK: - Se intacia SwiftData
    @State var favoriteDataBaseViewModel = DbSwiftDataViewModel.shared
    @State var singleCharacterViewModel: SingleCharacterViewModel = SingleCharacterViewModel()
    @State private var planetsViewModel: PlanetsViewModel = PlanetsViewModel()
    @State private var selectedCharacter: Character = Character(id: 0, name: "", ki: "", maxKi: "", race: "", gender: "", description: "", image: "", affiliation: "", deletedAt: nil)
    
    @State private var favoritesStar = false
    @State private var isTribute = false
    @State private var showListAudio = false
    
    // MARK: - Controla que vista se muestra
    @State private var selectedView = SelectedView.characters
    
    @State private var offset: CGFloat = 0
    @State private var scrollSpeed: CGFloat = 0
    
    @Namespace var animation
    @Namespace var winAnimation
    
    @State var showCharacterDetails: Bool = false
    @State var characterKiColor: Color = .yellow
    
    enum SelectedView {
        case characters, favoriteCharacters, planets
    }
    
    let defaultBackgroundImage = "Dragon"
    
 
    
    var body: some View {
        NavigationStack{
            ZStack{
                switch selectedView {
                case .characters:
                    AllCharactersView(animation: animation, showDetails: $showCharacterDetails, selectedCharacter: $selectedCharacter, selectedKiColor: $characterKiColor)
                        .environment(singleCharacterViewModel)
                        .padding(.horizontal, 25)
                case .favoriteCharacters:
                    FavoritesView(favoriteDataBaseViewModel: DbSwiftDataViewModel(), animation: animation)
                        .environment(singleCharacterViewModel)
                        .padding(.horizontal, 30)
                case .planets:
                    
                    ZStack{
                        Image("Cosmos2") 
                                      .resizable()
                                      .scaledToFill() // Escala la imagen para que llene todo el espacio
                                   //   .frame(width: .infinity, height: .infinity) // Ajusta el tamaño de la imagen
                                      .edgesIgnoringSafeArea(.all) // Ignora los bordes seguros y extiende la imagen a toda la pantalla
                        VStack{
                           
                            CardListPlanetesView(planets: planetsViewModel.allPlanets!)
                               
                        }//.frame(width: .infinity, height: 680, alignment: .center)
                    }
                    
                }
                
                if showListAudio{
                    CardListAudioView(showListAudio:  $showListAudio)
                        .matchedGeometryEffect(id: "reproduction", in: winAnimation)
                        .padding()
                }
            }
            
            .toolbar {
                
//                ToolbarItem(placement: .automatic){
//                    
//                    Button(action: {
//                        withAnimation(.spring( response: 0.5, dampingFraction: 0.8)){
//                            showListAudio.toggle()
//                        }
//                    }, label: {
//                        Image(systemName: "music.note.list")
//                            .foregroundStyle(Color.white)
//                            .shadow(color: .cyan,radius: 10)
//                            .bold()
//                            .font(.title2)
//                    })
//                    
//                }
                
//                ToolbarItem(placement: .automatic) {
//                    Menu{
//                        Button(action: {
//                            withAnimation(.spring){
//                                selectedView = .characters
//                            }
//                        }) {
//                            Text("Personajes")
//                            Image("GokuPeque")
//                                .resizable()
//                                .frame(width: 10, height: 10)
//                                .foregroundStyle(Color.white)
//                        }
//                        .disabled(selectedView == .characters)
//                        
//                        Button {
//                            withAnimation(.spring){
//                                selectedView = .planets
//                            }
//                        } label: {
//                            Text("Planetas")
//                            Image("planeta")
//                                .resizable()
//                                .scaledToFit()
//                                .frame(width: 1, height: 1)
//                        }
//                        .disabled(selectedView == .planets)
//                        
//                        Button(action: {
//                            selectedView = .favoriteCharacters
//                        }) {
//                            Text("Personajes favoritos")
//                            
//                            Image("Boll7")
//                                .resizable()
//                                .frame(width: 10, height: 10)
//                        }
//                        .disabled(selectedView == .favoriteCharacters)
//                    } label: {
//                        Image("logoGoku")
//                            .resizable()
//                            .renderingMode(.template)
//                            .frame(width: 40, height: 50)
//                            .foregroundStyle(Color.white)
//                            .shadow(color: .cyan, radius: 10)
//                        
//                    }
//                }
                
                ToolbarItem(placement: .navigation) {
                    Menu{
                        
                        Button(action: {
                            // Acción del botón de la barra de herramientas
                            isTribute = true
                        }) {
                            Text("Tributo a Akira Toriyama")
                            Image( "akira")
                                .resizable()
                                .frame(width: 10, height: 10)
                        }
                        
                    } label: {
                        Image(systemName: "info.circle")
                            .foregroundStyle(Color.white)
                            .shadow(color: .cyan, radius: 10)
                            .bold()
                            .font(.title2)
                    }
                }
            }
            .sheet(isPresented: $isTribute, content: {
                CardViewTribute()
            })
        }
        
        .overlay {
           
            if showCharacterDetails {
                CharacterDetailView(showDetails: $showCharacterDetails, animation: animation)
                    .environment(singleCharacterViewModel)
                    .onDisappear {
                        favoriteDataBaseViewModel.getFavorites()
                    }
                
            }
            
            
            
        }
        .overlay(alignment: .bottomLeading) {
            FloatingButton{
                
                FloatingAction(symbol: "iconoMusica") {
                    withAnimation(.spring){
                        showListAudio.toggle()
                    }
                }
                
                FloatingAction(symbol: "iconFavorito") {
                    withAnimation(.spring){
                        selectedView = .favoriteCharacters
                    }
                }
                
                FloatingAction(symbol: "iconoPlanet") {
                    withAnimation(.spring){
                        selectedView = .planets
                    }
                }
                
                FloatingAction(symbol: "iconCherater") {
                    withAnimation(.spring){
                        selectedView = .characters
                    }
                }
                
              
                
            } label: { isExpande in
                Image("Ball1").resizable()
              //  Image(systemName: "plus")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
                    .rotationEffect(.init(degrees: isExpande ?  45 : 0 ))
                    .scaleEffect(1.02)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(.clear, in: .circle)
                    /// Scaling effect When Expanded
                    .scaleEffect(isExpande ? 0.9 : 1)
                    
            }
            .padding(.bottom, 40)
            .padding(.horizontal, 20)

        }
    }
}

#Preview {
    //para mostrar la data en el simulador, llamar a los Mocks. De esta forma no se está llamando todo el dato a la API y la carga de datos es más rápida.
    //nil nos muestra los datos que ya se encuentran hardcodeados en el Mock, pero si no queremos que sea nil, y queremos pasar nuestros propios valores para probar, podemos hacerlo
    Home()
}
