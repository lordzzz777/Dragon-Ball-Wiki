//
//  BasicCharacterCardView.swift
//  DrgonBollWiki
//
//  Created by Jacob Aguilar on 13-03-24.
//

import SwiftUI

struct CharacterCardView: View {
    
    @State var favoriteDataBaseViewModel = DbSwiftDataViewModel.shared
    @Environment(SingleCharacterViewModel.self) var singleCharacterViewModel: SingleCharacterViewModel
    @State var character: Character
    @State private var isFavorite: Bool = false
    
    var animation: Namespace.ID
    
    var body: some View {
        ZStack {
            ZStack {
                RoundedRectangle(cornerRadius: 15)
                    .fill(.ultraThinMaterial)
            }
            .matchedGeometryEffect(id: "background\(character.id)", in: animation)
            
            AsyncImage(url: URL(string: character.image)) { image in
                image
                    .resizable()
                    .scaledToFit()
                    .matchedGeometryEffect(id: "image\(character.id)", in: animation)
                    .shadow(color: character.characterKiColor, radius: 15, x: 0, y: 0 )
            } placeholder: {
                ProgressView()
            }
            .frame(height: 400)
            .padding(.top, 20)
            
            VStack {
                HStack {
                    Text(character.ki)
                        .font(.body)
                        .fontWeight(.bold)
                        .matchedGeometryEffect(id: "ki\(character.id)", in: animation)
                        
                    Spacer()
                    
                    FavoriteButtonView(isFavorite: $isFavorite, characterID: character.id)
                        .matchedGeometryEffect(id: "favoriteButton\(character.id)", in: animation)
                        .onChange(of: favoriteDataBaseViewModel.favorites) {
                            favoriteDataBaseViewModel.getFavorites()
                            isFavorite = favoriteDataBaseViewModel.favorites.contains { $0.id == character.id }
                        }
                }
                
                Spacer()
                
                Text(character.name)
                    .font(.custom("SaiyanSans", size: 42))
                    .foregroundStyle(Color.yellow)
                    .shadow(color: .black, radius: 0, x: 1, y: 1)
                    .shadow(color: .white, radius: 0, x: -1, y: -1)
                    .matchedGeometryEffect(id: "characterName\(character.id)", in: animation)
            }
            .padding()
        }
        .matchedGeometryEffect(id: "allView\(character.id)", in: animation)
        .frame(maxHeight: 500)
        .task {
            isFavorite = favoriteDataBaseViewModel.favorites.contains { $0.id == character.id }
        }
    }
}

#Preview {
    @State var singleCharacterViewModel = SingleCharacterViewModel()
    @Namespace var animation
    let character = Character(id: 1, name: "Goku", ki: "60.000.000", maxKi: "90 Septillion", race: "Evil", gender: "Male", description: "El protagonista de la serie, conocido por su gran poder y personalidad amigable. Originalmente enviado a la Tierra como un infante volador con la misión de conquistarla. Sin embargo, el caer por un barranco le proporcionó un brutal golpe que si bien casi lo mata, este alteró su memoria y anuló todos los instintos violentos de su especie, lo que lo hizo crecer con un corazón puro y bondadoso, pero conservando todos los poderes de su raza. No obstante, en la nueva continuidad de Dragon Ball se establece que él fue enviado por sus padres a la Tierra con el objetivo de sobrevivir a toda costa a la destrucción de su planeta por parte de Freeza. Más tarde, Kakarot, ahora conocido como Son Goku, se convertiría en el príncipe consorte del monte Fry-pan y líder de los Guerreros Z, así como el mayor defensor de la Tierra y del Universo 7, logrando mantenerlos a salvo de la destrucción en innumerables ocasiones, a pesar de no considerarse a sí mismo como un héroe o salvador.", image: "https://dragonball-api.com/characters/goku_normal.webp", affiliation: "Z Fighter", deletedAt: nil)
    
    return CharacterCardView(character: character, animation: animation)
        .environment(singleCharacterViewModel)
        .preferredColorScheme(.dark)
}
