//
//  CharacterDetailView.swift
//  DrgonBollWiki
//
//  Created by Jacob Aguilar on 13-03-24.
//

import SwiftUI

struct CharacterDetailView: View {
    
    @State private var singleCharacterViewModel: SingleCharacterViewModel
    @State private var idTranformation: Int = 0
    @Binding var selectedCharacterKiColor: Color
    
    @Binding var showDetails: Bool
    let selectedCharacter: Character
    var animation: Namespace.ID
    
    init(singleCharacterViewModel: SingleCharacterProtocol, selectedCharacter: Character, selectedCharacterKiColor: Binding<Color>, animation: Namespace.ID, showDetails: Binding<Bool>) {
        _singleCharacterViewModel = State(wrappedValue: SingleCharacterViewModel(singleCharacterDataService: singleCharacterViewModel))
        _selectedCharacterKiColor = selectedCharacterKiColor
        _showDetails = showDetails
        self.selectedCharacter = selectedCharacter
        self.animation = animation
    }
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 30) {
                AsyncImage(url: URL(string: selectedCharacter.image)) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 490)
                .shadow(color: selectedCharacterKiColor , radius: 15, x: 0, y: 0 )
                .padding(.top, 70)
                
                VStack {
                    Text("\(selectedCharacter.name)")
                        .font(.custom("SaiyanSans", size: 42))
                        .foregroundStyle(Color.yellow)
                        .shadow(color: .black, radius: 0, x: 1, y: 1)
                        .shadow(color: .white, radius: 0, x: -1, y: -1)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                VStack {
                    HStack(alignment: .top) {
                        VStack(alignment: .leading) {
                            Text("Ki")
                            
                            Text("\(selectedCharacter.ki)")
                                .font(.body)
                                .fontWeight(.bold)
                        }
                        
                        Spacer()
                        
                        VStack(alignment: .trailing) {
                            Text("\(selectedCharacter.race)")
                                .font(.custom("SaiyanSans", size: 25))
                                .foregroundStyle(selectedCharacterKiColor)
                            
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
                    }
                }
                
                if let character = singleCharacterViewModel.character {
                    VStack {
                        ForEach(character.transformations, id: \.id) { transformation in
                            if transformation.id == idTranformation {
                                AsyncImage(url: URL(string: transformation.image)) { image in
                                    image
                                        .resizable()
                                        .scaledToFit()
                                } placeholder: {
                                    ProgressView()
                                }
                                .frame(height: 450).shadow(color: .orange , radius: 15, x: 0, y: 0 ).padding(.top, 10)
                                
                            }
                            
                        }
                        Picker(" ", selection: $idTranformation) {
                            ForEach(character.transformations, id: \.id){ item in
                                Text(item.name)
                                    .tag(item.id)
                            }
                        } .pickerStyle(.palette).padding()
                            .font(.custom("SaiyanSans", size: 40)).shadow(color: .blue , radius: 15, x: 0, y: 0 )
                    }
                }
            }
            .padding(.horizontal)
        }
        .background {
            ZStack {
                RoundedRectangle(cornerRadius: 0)
                    .fill(.black)
                    .opacity(0.9)
                    .blur(radius: 1)
                
                RoundedRectangle(cornerRadius: 0)
                    .fill(.ultraThinMaterial)
                    .blur(radius: 1)
                    .opacity(0.8)
            }
        }
        .overlay {
            VStack(alignment: .trailing) {
                Button {
                    withAnimation {
                        showDetails = false
                    }
                } label: {
                    Image(systemName: "xmark")
                        .foregroundStyle(Color.white)
                }
                
                Spacer()
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
            .padding(.trailing, 20)
            .padding(.top, 60)
        }
        .task {
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
    let selectedCharacter = Character(id: 1, name: "Goku", ki: "60.000.000", maxKi: "90 Septillion", race: "Saiyan", gender: "Male", description: "El protagonista de la serie, conocido por su gran poder y personalidad amigable. Originalmente enviado a la Tierra como un infante volador con la misión de conquistarla. Sin embargo, el caer por un barranco le proporcionó un brutal golpe que si bien casi lo mata, este alteró su memoria y anuló todos los instintos violentos de su especie, lo que lo hizo crecer con un corazón puro y bondadoso, pero conservando todos los poderes de su raza. No obstante, en la nueva continuidad de Dragon Ball se establece que él fue enviado por sus padres a la Tierra con el objetivo de sobrevivir a toda costa a la destrucción de su planeta por parte de Freeza. Más tarde, Kakarot, ahora conocido como Son Goku, se convertiría en el príncipe consorte del monte Fry-pan y líder de los Guerreros Z, así como el mayor defensor de la Tierra y del Universo 7, logrando mantenerlos a salvo de la destrucción en innumerables ocasiones, a pesar de no considerarse a sí mismo como un héroe o salvador.", image: "https://res.cloudinary.com/dgtgbyo76/image/upload/v1699044374/hlpy6q013uw3itl5jzic.webp", affiliation: "Z Fighter", deletedAt: nil)
    
    return CharacterDetailView(singleCharacterViewModel: MockSingleCharacterDataService(testData: nil), selectedCharacter: selectedCharacter, selectedCharacterKiColor: .constant(Color.yellow), animation: animation, showDetails: .constant(true))
        .preferredColorScheme(.dark)
}
