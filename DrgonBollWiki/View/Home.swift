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
    
    // MARK: - Controla que vista se muestra
    @State private var selectedView = SelectedView.characters
    
    @State private var offset: CGFloat = 0
    @State private var scrollSpeed: CGFloat = 0
    
    @Namespace var animation
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
                        .padding(.horizontal, 30)
                case .favoriteCharacters:
                    FavoritesView(animation: animation)
                        .environment(singleCharacterViewModel)
                        .padding(.horizontal, 30)
                case .planets:
                    Text("En construcción")
                }
                
                
                VStack{
                    Image("Boll7")
                        .resizable()
                        .frame(width: 450, height: 450)
                        .offset(x: -100, y: 375)
                        .shadow(radius: 8)
                }
            }
            .toolbar {
                ToolbarItem(placement: .automatic) {
                    Menu{
                        Button(action: {
                            selectedView = .characters
                        }) {
                            Text("Personajes")
                            Image("GokuPeque")
                                .resizable()
                                .frame(width: 10, height: 10)
                        }
                        .disabled(selectedView == .characters)
                        
                        Button {
                            selectedView = .planets
                        } label: {
                            Text("Planetas")
                            Image("planeta")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 1, height: 1)
                        }
                        .disabled(selectedView == .planets)
                        
                        Button(action: {
                            selectedView = .favoriteCharacters
                        }) {
                            Text("Personajes favoritos")
                            
                            Image("Boll7")
                                .resizable()
                                .frame(width: 10, height: 10)
                        }
                        .disabled(selectedView == .favoriteCharacters)
                    } label: {
                        Image("logoGoku")
                            .resizable()
                            .renderingMode(.template)
                            .foregroundColor(Color.primary)
                            .frame(width: 40, height: 50)
                    }
                }
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
                            .foregroundStyle(Color.primary)
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
    }
}

#Preview {
    //para mostrar la data en el simulador, llamar a los Mocks. De esta forma no se está llamando todo el dato a la API y la carga de datos es más rápida.
    //nil nos muestra los datos que ya se encuentran hardcodeados en el Mock, pero si no queremos que sea nil, y queremos pasar nuestros propios valores para probar, podemos hacerlo
    Home()
}
