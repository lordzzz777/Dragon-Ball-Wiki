//
//  CardViewCarousel.swift
//  DrgonBollWiki
//
//  Created by Esteban Perez Castillejo on 11/3/24.
//

import SwiftUI

struct CardViewCarousel: View {
    
    // MARK: - Se intacia SwiftData
    @State var dbSwiftDataModel: [DbSwiftDataModel]
    @Environment (DbSwiftDataViewModel.self) var viewModelisFavorites
    
    // MARK: - Se intacias modelos y el ViewModel de Personajes
    @State private var allCharactersViewModel: AllCharactersViewModel = AllCharactersViewModel()
    @State private var planetsViewModel: PlanetsViewModel = PlanetsViewModel()
    @State private var selectedCharacter: Character?
    @State private var selectedCharacterId: Int?
    
    // MARK: - View Properties
    @State private var modeViewCard = false
    @State private var isRotationEnabled: Bool = true
    @State private var showIndicator: Bool = false
    @State private var isShowDetails = false
    @State private var favoritesStar = false
    @State private var isFlipped = false
    @State private var isProgress = 0.6
    
    
    
    init(dbSwiftDataModel: [DbSwiftDataModel]) {
        _dbSwiftDataModel = State(initialValue: dbSwiftDataModel)
      //  _dbSwiftDataViewModel = State(initialValue: DbSwiftDataViewModel())
    }
    
    let color: [Color] = [.red, .blue, .cyan, .yellow, .gray, .green, .indigo]
    
    var body: some View {
        if allCharactersViewModel.isLoading{
            ProgressView()
        }
        
        ScrollView(.horizontal){
            HStack{
                ForEach(allCharactersViewModel.allCharacters, id:\.id){ character in
                    ZStack{
                       // ColorView(color: color[character.id % color.count]).padding(.bottom, 90).opacity(0.2)
                        Card(character: character, playSound: {
                            allCharactersViewModel.playCardSound() })
                        .padding()
                        .onTapGesture {
                            withAnimation {
                                isFlipped.toggle()
                            }
                        }
                    }
                    .contextMenu(ContextMenu(menuItems: {
                        Button(action: {
                            selectedCharacterId = character.id
                            isShowDetails = true
                        }, label: {
                            Text("Saber Mas")
                            Image(systemName: "book")
                        })
                        Button(action: {
                           favoritesStar = true
                            viewModelisFavorites.saveFavorites(character.id, favoritesStar)
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
                    .sheet(isPresented: $isShowDetails, content: {
                        DetailsView(selectedCharacter: character)
                    })
                }
            }.scrollTargetLayout()
                .padding(.horizontal)
        } .scrollTargetBehavior(.viewAligned)
            .padding(.horizontal, 100)
    }
}

#Preview {
    CardViewCarousel(dbSwiftDataModel: [])
}
