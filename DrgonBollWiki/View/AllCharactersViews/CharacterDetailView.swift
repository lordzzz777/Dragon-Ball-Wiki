//
//  CharacterDetailView.swift
//  DrgonBollWiki
//
//  Created by Jacob Aguilar on 13-03-24.
//

import SwiftUI

struct CharacterDetailView: View {
    
    @State var favoriteDataBaseViewModel = DbSwiftDataViewModel.shared
    @Environment(SingleCharacterViewModel.self) private var singleCharacterViewModel: SingleCharacterViewModel
    @State private var idTranformation: Int = 0
    @State private var isFavorite: Bool = false
    
    @State var characterKiColor: Color = .yellow
    @Binding var showDetails: Bool
    var selectedCharacter: Character {
        guard let selectedCharacter = singleCharacterViewModel.selectedCharacter else {
            return self.selectedCharacter
        }
        
        return selectedCharacter
    }
    var animation: Namespace.ID
    
    var body: some View {
        ZStack {
            ZStack {
//                RoundedRectangle(cornerRadius: 0)
//                    .fill(.black)
//                    .opacity(0.45)
                
                RoundedRectangle(cornerRadius: 0)
                    .fill(.ultraThinMaterial)
            }
            .matchedGeometryEffect(id: "background\(selectedCharacter.id)", in: animation)
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 30) {
                    AsyncImage(url: URL(string: selectedCharacter.image)) { image in
                        image
                            .resizable()
                            .scaledToFit()
                            .matchedGeometryEffect(id: "image\(selectedCharacter.id)", in: animation)
                            .shadow(color: singleCharacterViewModel.selectedCharacterKiColor , radius: 15, x: 0, y: 0 )
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(height: 500)
                    .padding(.top, 70)
                    
                    HStack {
                        Text("\(selectedCharacter.name)")
                            .font(.custom("SaiyanSans", size: 42))
                            .foregroundStyle(Color.yellow)
                            .shadow(color: .black, radius: 0, x: 1, y: 1)
                            .shadow(color: .white, radius: 0, x: -1, y: -1)
                            .matchedGeometryEffect(id: "characterName\(selectedCharacter.id)", in: animation)
                        
                        Spacer()
                        
                        FavoriteButtonView(isFavorite: $isFavorite, characterID: selectedCharacter.id)
                            .matchedGeometryEffect(id: "favoriteButton\(selectedCharacter.id)", in: animation)
                            .onChange(of: favoriteDataBaseViewModel.favorites) {
                                favoriteDataBaseViewModel.getFavorites()
                                isFavorite = favoriteDataBaseViewModel.favorites.contains { $0.id == selectedCharacter.id }
                            }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    VStack {
                        HStack(alignment: .top) {
                            VStack(alignment: .leading) {
                                Text("Ki")
                                
                                Text("\(selectedCharacter.ki)")
                                    .font(.body)
                                    .fontWeight(.bold)
                                    .matchedGeometryEffect(id: "ki\(selectedCharacter.id)", in: animation)
                            }
                            
                            Spacer()
                            
                            VStack(alignment: .trailing) {
                                Text("\(selectedCharacter.race)")
                                    .font(.custom("SaiyanSans", size: 25))
                                    .foregroundStyle(singleCharacterViewModel.selectedCharacterKiColor)
                                
                                Text("\(selectedCharacter.affiliation)")
                                    .font(.custom("SaiyanSans", size: 25))
                                    .foregroundStyle(Color.red)
                            }
                        }
                    }
                    
                    Text("\(selectedCharacter.description)")
                    
                    if let transformation = singleCharacterViewModel.character?.transformations {
                        if transformation.count > 0 {
                            Text("Transformaciones ")
                                .fontWeight(.bold)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.bottom, -15)
                        }
                    }
                    
                    if let character = singleCharacterViewModel.character {
                        VStack {
                            //Custom segmented control
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack {
                                    ForEach(character.transformations, id: \.id){ transformation in
                                        if transformation.id != idTranformation {
                                            Text(transformation.name)
                                                .font(.footnote)
                                                .fontWeight(.semibold)
                                                .foregroundStyle(transformation.id != idTranformation ? .white : .black)
                                                .background {
                                                    RoundedRectangle(cornerRadius: 8)
                                                        .fill(Color.clear)
                                                }
                                                .padding(5)
                                                .onTapGesture {
                                                    withAnimation {
                                                        idTranformation = transformation.id
                                                    }
                                                }
                                        } else {
                                            Text(transformation.name)
                                                .font(.footnote)
                                                .fontWeight(.semibold)
                                                .foregroundStyle(transformation.id != idTranformation ? .white : .black)
                                                .padding(7)
                                                .background {
                                                    RoundedRectangle(cornerRadius: 8)
                                                        .fill(singleCharacterViewModel.selectedCharacterKiColor)
                                                        .matchedGeometryEffect(id: "transformation", in: animation)
                                                }
                                                .onTapGesture {
                                                    withAnimation {
                                                        idTranformation = transformation.id
                                                    }
                                                }
                                        }
                                    }
                                }
                                .background {
                                    RoundedRectangle(cornerRadius: 8)
                                        .fill(.ultraThinMaterial)
                                }
                                .frame(maxWidth: .infinity, alignment: .center)
                            }
                            
                            if let selectedTransformation = character.transformations.first(where: { $0.id == idTranformation }) {
                                if idTranformation == 4 && character.id == 1 {
                                    Image("SuperShayan4")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 300, height: 450)
                                        .shadow(color: singleCharacterViewModel.selectedCharacterKiColor, radius: 15, x: 0, y: 0)
                                        .padding(.top, 10)
                                } else if character.id == 16 && idTranformation == 27 {
                                    Image("trunksssj2")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: 500)
                                        .shadow(color: singleCharacterViewModel.selectedCharacterKiColor, radius: 15, x: 0, y: 0)
                                } else {
                                    AsyncImage(url: URL(string: selectedTransformation.image)) { image in
                                        image
                                            .resizable()
                                            .scaledToFit()
                                    } placeholder: {
                                        ProgressView()
                                    }
                                    .frame(height: 450)
                                    .shadow(color: singleCharacterViewModel.selectedCharacterKiColor, radius: 15, x: 0, y: 0)
                                    .padding(.top, 10)
                                }
                            }
                        }
                    }
                }
                .padding(.horizontal)
            }
        }
        .matchedGeometryEffect(id: "allView\(selectedCharacter.id)", in: animation)
        .overlay {
            VStack(alignment: .trailing) {
                Button {
                    withAnimation(.spring(response: 0.3, dampingFraction: 1)) {
                        showDetails = false
                    }
                } label: {
                    Image(systemName: "xmark")
                        .font(.footnote)
                        .fontWeight(.semibold)
                        .foregroundStyle(Color.white)
                        .padding(7)
                        .background {
                            RoundedRectangle(cornerRadius: 100)
                                .fill(.ultraThinMaterial)
                        }
                }
                
                Spacer()
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
            .padding(.trailing, 20)
            .padding(.top, 60)
        }
        .task {
            isFavorite = favoriteDataBaseViewModel.favorites.contains { $0.id == selectedCharacter.id }
            await singleCharacterViewModel.getCharacterInformation(characterID: selectedCharacter.id)
            
            guard let character = singleCharacterViewModel.character else {
                return
            }
            
            if character.transformations.count > 0 {
                idTranformation = character.transformations [0].id
            }
        }
    }
}

#Preview {
    @Namespace var animation
    @State var singleCharacterViewModel = SingleCharacterViewModel()
    singleCharacterViewModel.selectedCharacter = Character(id: 1, name: "Goku", ki: "60.000.000", maxKi: "90 Septillion", race: "Saiyan", gender: "Male", description: "El protagonista de la serie, conocido por su gran poder y personalidad amigable. Originalmente enviado a la Tierra como un infante volador con la misión de conquistarla. Sin embargo, el caer por un barranco le proporcionó un brutal golpe que si bien casi lo mata, este alteró su memoria y anuló todos los instintos violentos de su especie, lo que lo hizo crecer con un corazón puro y bondadoso, pero conservando todos los poderes de su raza. No obstante, en la nueva continuidad de Dragon Ball se establece que él fue enviado por sus padres a la Tierra con el objetivo de sobrevivir a toda costa a la destrucción de su planeta por parte de Freeza. Más tarde, Kakarot, ahora conocido como Son Goku, se convertiría en el príncipe consorte del monte Fry-pan y líder de los Guerreros Z, así como el mayor defensor de la Tierra y del Universo 7, logrando mantenerlos a salvo de la destrucción en innumerables ocasiones, a pesar de no considerarse a sí mismo como un héroe o salvador.", image: "https://res.cloudinary.com/dgtgbyo76/image/upload/v1699044374/hlpy6q013uw3itl5jzic.webp", affiliation: "Z Fighter", deletedAt: nil)
    
    return CharacterDetailView(showDetails: .constant(true), animation: animation)
        .environment(singleCharacterViewModel)
        .preferredColorScheme(.dark)
}
