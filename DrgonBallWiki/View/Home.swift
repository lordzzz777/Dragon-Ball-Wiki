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
                      AllCharactersView(animation: animation,
                      showDetails: $showCharacterDetails,
                      selectedCharacter: $selectedCharacter,
                      selectedKiColor: $characterKiColor)
                        .environment(singleCharacterViewModel)
                        .padding(.horizontal, 25)
                case .favoriteCharacters:
                    Image("Cosmos4")
                        .resizable()
                        .scaledToFill()
                        .edgesIgnoringSafeArea(.all)
                        .overlay {
                            FavoritesView(favoriteDataBaseViewModel: DbSwiftDataViewModel(), animation: animation)
                                    .environment(singleCharacterViewModel)
                                    .padding(.horizontal, 30)
                            }
                case .planets:
                    ZStack {
                        Image("Cosmos2") 
                            .resizable()
                            .scaledToFill() // Escala la imagen para que llene todo el espacio
                            .edgesIgnoringSafeArea(.all) // Ignora los bordes seguros y extiende la imagen a toda la pantalla
                        VStack {
                            CardListPlanetesView(planets: planetsViewModel.allPlanets!)
                        }
                    }
                }
                
                if showListAudio {
                    CardListAudioView(showListAudio:  $showListAudio)
                        .matchedGeometryEffect(id: "reproduction", in: winAnimation)
                        .padding()
                }
            }
            
            .toolbar {
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
            
        } .overlay {
            if showCharacterDetails {
                CharacterDetailView(showDetails: $showCharacterDetails, animation: animation)
                    .environment(singleCharacterViewModel)
                    .onDisappear {
                        favoriteDataBaseViewModel.getFavorites()
                    }
            }
            
        } .overlay(alignment: .bottomLeading) {
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
                
            } label: {
                Image("Ball1").resizable()
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
                    .rotationEffect(.init(degrees: $0 ?  45 : 0 ))
                    .scaleEffect(1.02)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(.clear, in: .circle)
                
                    /// Scaling effect When Expanded
                    .scaleEffect($0 ? 0.9 : 1)
                    
            }
            .padding(.bottom, 40)
            .padding(.horizontal, 20)

        }
    }
}

#Preview {
    Home()
}
