//
//  FavoriteCardView.swift
//  DrgonBollWiki
//
//  Created by Jacob Aguilar on 21-03-24.
//

import SwiftUI

struct FavoriteCardView: View {
    
    @State var favoriteDataBaseViewModel = DbSwiftDataViewModel.shared
    @Environment(SingleCharacterViewModel.self) var singlesingleCharacterViewModel: SingleCharacterViewModel
    @State var singleCharacter: SingleCharacter
    
    var animation: Namespace.ID
    @State private var isFavorite: Bool = false
    var singleCharacterKiColor: Color {
        switch singleCharacter.race {
        case "Evil":
            .black
        case "Android":
            .cyan
        case "Majin":
            .pink
        case "Nucleico":
            .white
        case "Namekian":
            .green
        case "Saiyan":
            .yellow
        case "Jiren Race":
            .red
        case "Frieza Race":
            .gray
        case "Nucleico benigno":
            .brown
        case "Human":
            .blue
        case "Angel":
            .mint
        case "God":
            .indigo
        case "Unknown":
            .white
        default:
            .white
        }
    }
    
    var body: some View {
        ZStack {
            ZStack {
//                RoundedRectangle(cornerRadius: 15)
//                    .fill(.black)
//                    .opacity(0.45)
                
                RoundedRectangle(cornerRadius: 15)
                    .fill(.ultraThinMaterial)
            }
            .matchedGeometryEffect(id: "background\(singleCharacter.id)", in: animation)
            
            AsyncImage(url: URL(string: singleCharacter.image)) { image in
                image
                    .resizable()
                    .scaledToFit()
                    .matchedGeometryEffect(id: "image\(singleCharacter.id)", in: animation)
                    .shadow(color: singleCharacterKiColor , radius: 15, x: 0, y: 0 )
            } placeholder: {
                ProgressView()
            }
            .frame(height: 300)
            .padding(.top, 20)
            
            VStack {
                HStack {
                    Text(singleCharacter.ki)
                        .font(.body)
                        .fontWeight(.bold)
                        .matchedGeometryEffect(id: "ki\(singleCharacter.id)", in: animation)
                        
                    Spacer()
                    
//                    FavoriteButtonView(isFavorite: $isFavorite, singleCharacterID: singleCharacter.id)
//                        .matchedGeometryEffect(id: "favoriteButton\(singleCharacter.id)", in: animation)
//                        .onChange(of: favoriteDataBaseViewModel.favorites) {
//                            favoriteDataBaseViewModel.getFavorites()
//                            isFavorite = favoriteDataBaseViewModel.favorites.contains { $0.id == singleCharacter.id }
//                        }
                }
                
                Spacer()
                
                Text(singleCharacter.name)
                    .font(.custom("SaiyanSans", size: 42))
                    .foregroundStyle(Color.yellow)
                    .shadow(color: .black, radius: 0, x: 1, y: 1)
                    .shadow(color: .white, radius: 0, x: -1, y: -1)
                    .matchedGeometryEffect(id: "singleCharacterName\(singleCharacter.id)", in: animation)
            }
            .padding()
        }
        .matchedGeometryEffect(id: "allView\(singleCharacter.id)", in: animation)
        .frame(maxHeight: 300)
        .task {
            isFavorite = favoriteDataBaseViewModel.favorites.contains { $0.id == singleCharacter.id }
        }
    }
}

#Preview {
    @Namespace var animation
    @State var singleCharacterViewModel = SingleCharacterViewModel()
    let singleCharacter = SingleCharacter(id: 1, name: "Goku", ki: "60.000.000", maxKi: "90 Septillion", race: "Saiyan", gender: "Male", description: "El protagonista de la serie, conocido por su gran poder y personalidad amigable. Originalmente enviado a la Tierra como un infante volador con la misión de conquistarla. Sin embargo, el caer por un barranco le proporcionó un brutal golpe que si bien casi lo mata, este alteró su memoria y anuló todos los instintos violentos de su especie, lo que lo hizo crecer con un corazón puro y bondadoso, pero conservando todos los poderes de su raza. No obstante, en la nueva continuidad de Dragon Ball se establece que él fue enviado por sus padres a la Tierra con el objetivo de sobrevivir a toda costa a la destrucción de su planeta por parte de Freeza. Más tarde, Kakarot, ahora conocido como Son Goku, se convertiría en el príncipe consorte del monte Fry-pan y líder de los Guerreros Z, así como el mayor defensor de la Tierra y del Universo 7, logrando mantenerlos a salvo de la destrucción en innumerables ocasiones, a pesar de no considerarse a sí mismo como un héroe o salvador.", image: "https://dragonball-api.com/characters/goku_normal.webp", affiliation: "Z Fighter", deletedAt: nil, originPlanet: OriginPlanet(id: 1, name: "Namek", isDestroyed: true, description: "Planeta natal de los Namekianos. Escenario de importantes batallas y la obtención de las Dragon Balls de Namek.", image: "https://res.cloudinary.com/dgtgbyo76/image/upload/v1699145134/wxedvvh8kiyw00psvphl.webp", deletedAt: nil), transformations: [Transformation(id: 1, name: "Goku SSJ", image: "https://res.cloudinary.com/dgtgbyo76/image/upload/v1699050838/x8vdjitiaygwbrbh3ps9.png", ki: "3 Billion", deletedAt: nil), Transformation(id: 1, name: "Goku SSJ", image: "https://res.cloudinary.com/dgtgbyo76/image/upload/v1699050838/x8vdjitiaygwbrbh3ps9.png", ki: "3 Billion", deletedAt: nil), Transformation(id: 1, name: "Goku SSJ", image: "https://res.cloudinary.com/dgtgbyo76/image/upload/v1699050838/x8vdjitiaygwbrbh3ps9.png", ki: "3 Billion", deletedAt: nil), Transformation(id: 1, name: "Goku SSJ", image: "https://res.cloudinary.com/dgtgbyo76/image/upload/v1699050838/x8vdjitiaygwbrbh3ps9.png", ki: "3 Billion", deletedAt: nil)])
    
    return FavoriteCardView(singleCharacter: singleCharacter, animation: animation)
        .environment(singleCharacterViewModel)
}
