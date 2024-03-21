//
//  AllCharactersView.swift
//  DrgonBollWiki
//
//  Created by Jacob Aguilar on 13-03-24.
//

import SwiftUI

struct AllCharactersView: View {
    
    @State var favoriteDataBaseViewModel = DbSwiftDataViewModel.shared
    @Environment(SingleCharacterViewModel.self) var singleCharacterViewModel: SingleCharacterViewModel
    @State var allCharactersViewModel: AllCharactersViewModel = AllCharactersViewModel()
    @Environment(\.colorScheme) var colorScheme
//    @Binding var allCharacters: [Character]
    private let itemWidth: CGFloat = 300
    
    var animation: Namespace.ID
    @Binding var showDetails: Bool
    @Binding var selectedCharacter: Character
    @Binding var selectedKiColor: Color
    @State private var isFavorite: Bool = false
    
    //Search button
    @Namespace var searchAnimation
    @State private var searchButtonAnimation: Bool = false
    @State private var searchedCharacterName: String = ""
    
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                if !searchButtonAnimation {
                    VStack {
                        
                        Text("Personajes")
                            .font(.custom("SaiyanSans", size: 60))
                            .foregroundStyle(Color.red)
                            .shadow(color: .black, radius: 0, x: 1, y: 1)
                            .shadow(color: .black, radius: 0, x: -1, y: -1)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 10)
                        
                        Spacer()
                    }
                }
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 20) {
                        ForEach(allCharactersViewModel.allCharacters, id: \.id) { character in
                            CharacterCardView(character: character, animation: animation)
                                .environment(singleCharacterViewModel)
                                .frame(width: itemWidth)
                                .opacity(showDetails ? 0 : 1)
                                .onTapGesture {
                                    singleCharacterViewModel.getKiColor(character: character)
                                    singleCharacterViewModel.selectedCharacter = character
                                    withAnimation(.spring(response: 0.5, dampingFraction: 1)) {
                                        showDetails = true
                                    }
                                }
                                .onLongPressGesture(perform: {
                                    favoriteDataBaseViewModel.getFavorites()
                                    isFavorite = favoriteDataBaseViewModel.favorites.contains { $0.id == character.id }
                                })
                                .contextMenu(ContextMenu(menuItems: {
                                    Button(action: {
                                        if isFavorite {
                                            favoriteDataBaseViewModel.deleteFavoriteWith(id: character.id)
                                            isFavorite = false
                                        } else {
                                            favoriteDataBaseViewModel.saveFavorites(character.id, false)
                                            isFavorite = true
                                        }
                                    }, label: {
                                        Text(isFavorite ? "Eliminar de favoritos" : "Guardar en favoritos")
                                        Image(systemName: isFavorite ? "star.slash" : "star.fill")
                                            .onAppear {
                                                favoriteDataBaseViewModel.getFavorites()
                                                isFavorite = favoriteDataBaseViewModel.favorites.contains { $0.id == character.id }
                                                print("Personaje: \(character.id) es favorito: \(isFavorite)")
                                            }
                                    })
                                    
                                    Button(action: {
                                        singleCharacterViewModel.getKiColor(character: character)
                                        singleCharacterViewModel.selectedCharacter = character
                                        withAnimation(.spring(response: 0.5, dampingFraction: 1)) {
                                            showDetails = true
                                        }
                                    }, label: {
                                        Text("Saber Más")
                                        Image(systemName: "book")
                                    })
                                    
                                    Button(action: {
                                        // logica
                                    }, label: {
                                        Text("Copiar")
                                        Image(systemName: "doc.on.doc")
                                    })
                                    
                                })
                                )
                        }
                    }
                    .padding(.horizontal, (proxy.size.width - itemWidth) / 2)
                    .scrollTargetLayout()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
                .scrollTargetBehavior(.viewAligned)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .ignoresSafeArea()
                .opacity(searchedCharacterName.isEmpty ? 1 : 0)
                
                if !searchedCharacterName.isEmpty {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 20) {
                            ForEach(allCharactersViewModel.searchedCharacters, id: \.id) { character in
                                CharacterCardView(character: character, animation: animation)
                                    .environment(singleCharacterViewModel)
                                    .frame(width: itemWidth)
                                    .opacity(showDetails ? 0 : 1)
                                    .onTapGesture {
                                        singleCharacterViewModel.getKiColor(character: character)
                                        singleCharacterViewModel.selectedCharacter = character
                                        withAnimation(.spring(response: 0.5, dampingFraction: 1)) {
                                            showDetails = true
                                        }
                                    }
                                    .onLongPressGesture(perform: {
                                        favoriteDataBaseViewModel.getFavorites()
                                        isFavorite = favoriteDataBaseViewModel.favorites.contains { $0.id == character.id }
                                    })
                                    .contextMenu(ContextMenu(menuItems: {
                                        Button(action: {
                                            if isFavorite {
                                                favoriteDataBaseViewModel.deleteFavoriteWith(id: character.id)
                                                isFavorite = false
                                            } else {
                                                favoriteDataBaseViewModel.saveFavorites(character.id, false)
                                                isFavorite = true
                                            }
                                        }, label: {
                                            Text(isFavorite ? "Eliminar de favoritos" : "Guardar en favoritos")
                                            Image(systemName: isFavorite ? "star.slash" : "star.fill")
                                                .onAppear {
                                                    favoriteDataBaseViewModel.getFavorites()
                                                    isFavorite = favoriteDataBaseViewModel.favorites.contains { $0.id == character.id }
                                                    print("Personaje: \(character.id) es favorito: \(isFavorite)")
                                                }
                                        })
                                        
                                        Button(action: {
                                            singleCharacterViewModel.getKiColor(character: character)
                                            singleCharacterViewModel.selectedCharacter = character
                                            withAnimation(.spring(response: 0.5, dampingFraction: 1)) {
                                                showDetails = true
                                            }
                                        }, label: {
                                            Text("Saber Más")
                                            Image(systemName: "book")
                                        })
                                        
                                        Button(action: {
                                            // logica
                                        }, label: {
                                            Text("Copiar")
                                            Image(systemName: "doc.on.doc")
                                        })
                                        
                                    })
                                    )
                            }
                        }
                        .padding(.horizontal, (proxy.size.width - itemWidth) / 2)
                        .scrollTargetLayout()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                    .scrollTargetBehavior(.viewAligned)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .ignoresSafeArea()
                }
                
                //Search button y search bar
                if searchButtonAnimation {
                    VStack {
                        ZStack {
                            RoundedRectangle(cornerRadius: 40)
                                .fill(.ultraThinMaterial)
                            
                            HStack {
                                Image(systemName: "magnifyingglass")
                                    .foregroundStyle(Color.white)
                                    .padding(.horizontal, 7)
                                
                                Divider()
                                
                                ZStack(alignment: .leading) {
                                    if searchedCharacterName.isEmpty {
                                        Text("Busca un personaje")
                                            .foregroundStyle(Color.secondary)
                                    }
                                    
                                    TextField("", text: $searchedCharacterName)
                                        .onChange(of: searchedCharacterName) {
                                            allCharactersViewModel.searchCharacter(characterName: searchedCharacterName)
                                        }
                                }
                                
                                Image(systemName: "xmark")
                                    .foregroundStyle(Color.white)
                                    .onTapGesture {
                                        searchedCharacterName = ""
                                        withAnimation(.spring(response: 0.3, dampingFraction: 0.8)) {
                                            searchButtonAnimation = false
                                        }
                                    }
                            }
                            .padding(.horizontal, 12)
                        }
                        .matchedGeometryEffect(id: "searchbar", in: searchAnimation)
                        .frame(maxWidth: .infinity, maxHeight: 40)
                        .shadow(color: colorScheme == .light ? .black.opacity(0.5) : .black, radius: 10)
                        .padding(.horizontal, 10)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                } else {
                    VStack {
                        ZStack {
                            RoundedRectangle(cornerRadius: 40)
                                .fill(.ultraThinMaterial)
                            
                            Image(systemName: "magnifyingglass")
                                .foregroundStyle(Color.white)
                        }
                        .matchedGeometryEffect(id: "searchbar", in: searchAnimation)
                        .frame(width: 50, height: 50)
                        .shadow(color: colorScheme == .light ? .black.opacity(0.5) : .black, radius: 10)
                        .onTapGesture {
                            withAnimation(.spring(response: 0.5, dampingFraction: 0.8)) {
                                searchButtonAnimation = true
                            }
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
                    .padding()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        }
        .background {
            ZStack {
                if colorScheme == .light {
                    LinearGradient(gradient: Gradient(colors: [Color.red, Color.blue]), startPoint: .topLeading, endPoint: .bottomTrailing)
                        .edgesIgnoringSafeArea(.all)
                }
                
                Image("Dragon")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 600, height: 800)
                    .opacity(0.6)
                    .ignoresSafeArea()
            }
        }
        .task {
            favoriteDataBaseViewModel.getFavorites()
        }
    }
}

#Preview {
    @State var singleCharacterViewModel = SingleCharacterViewModel()
    @State var allCharactersViewModel = AllCharactersViewModel()
    
    @State var selectedCharacter: Character = Character(id: 1, name: "Goku", ki: "60.000.000", maxKi: "90 Septillion", race: "Evil", gender: "Male", description: "El protagonista de la serie, conocido por su gran poder y personalidad amigable. Originalmente enviado a la Tierra como un infante volador con la misión de conquistarla. Sin embargo, el caer por un barranco le proporcionó un brutal golpe que si bien casi lo mata, este alteró su memoria y anuló todos los instintos violentos de su especie, lo que lo hizo crecer con un corazón puro y bondadoso, pero conservando todos los poderes de su raza. No obstante, en la nueva continuidad de Dragon Ball se establece que él fue enviado por sus padres a la Tierra con el objetivo de sobrevivir a toda costa a la destrucción de su planeta por parte de Freeza. Más tarde, Kakarot, ahora conocido como Son Goku, se convertiría en el príncipe consorte del monte Fry-pan y líder de los Guerreros Z, así como el mayor defensor de la Tierra y del Universo 7, logrando mantenerlos a salvo de la destrucción en innumerables ocasiones, a pesar de no considerarse a sí mismo como un héroe o salvador.", image: "https://res.cloudinary.com/dgtgbyo76/image/upload/v1699044374/hlpy6q013uw3itl5jzic.webp", affiliation: "Z Fighter", deletedAt: nil)
    
    @Namespace var animation
    return AllCharactersView(animation: animation, showDetails: .constant(false), selectedCharacter: $selectedCharacter, selectedKiColor: .constant(.yellow))
        .environment(singleCharacterViewModel)
        .preferredColorScheme(.dark)
}
