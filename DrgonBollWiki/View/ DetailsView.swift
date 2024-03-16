//
//   DetailsView.swift
//  DrgonBollWiki
//
//  Created by Esteban Perez Castillejo on 4/3/24.
//

import SwiftUI

struct DetailsView: View {
    @State private var singleCharacterViewModel: SingleCharacterViewModel = SingleCharacterViewModel()
    @State var selectedCharacter: Character
    @State private var idTranformation = 0
    
    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                AsyncImage(url: URL(string: selectedCharacter.image)) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 490).shadow(color: .orange , radius: 15, x: 0, y: 0 ).padding(.top, 10)
                
                VStack {
                    Text("\(selectedCharacter.name)")
                        .font(.custom("SaiyanSans", size: 40)).shadow(color: .blue , radius: 15, x: 0, y: 0 )
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                VStack {
                    HStack(alignment: .top) {
                        VStack(alignment: .leading) {
                            Text("Ki")
                            
                            Text("\(selectedCharacter.ki)")
                        }
                        
                        Spacer()
                        
                        VStack(alignment: .trailing) {
                            Text("\(selectedCharacter.race)").font(.custom("SaiyanSans", size: 20)).foregroundStyle(Color.yellow)
                            Text("\(selectedCharacter.affiliation)").modifier(CustomFond(size: 40, shadow: 0.5 , colorShadow: .blue, colorFont: .red))
                        }
                    }
                }
                
                Text("\(selectedCharacter.description)")
                
                if let transformation = singleCharacterViewModel.character?.transformations {
                    if transformation.count > 0 {
                        Text("Transformaciones ")
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
                
            //    ScrollView(.horizontal) {
                    if let character = singleCharacterViewModel.character {
                        VStack {
                          
                               // ForEach(character.transformations, id: \.id) { transformation in
//                                    if transformation.id == 1 && idTranformation == 4 {
//                                           Image("SuperShayan4")
//                                            .resizable()
//                                                .frame(height: 450).shadow(color: .orange , radius: 15, x: 0, y: 0 ).padding(.top, 10)
//                                        
//                                    }
//                                    if transformation.id == idTranformation {
//                                        AsyncImage(url: URL(string: transformation.image)) { image in
//                                            image
//                                                .resizable()
//                                                .scaledToFit()
//                                        } placeholder: {
//                                            ProgressView()
//                                        }
//                                        .frame(height: 450).shadow(color: .orange , radius: 15, x: 0, y: 0 ).padding(.top, 10)
//                                       
//                                    }
                            //  }
                                    if let selectedTransformation = character.transformations.first(where: { $0.id == idTranformation }) {
                                            if idTranformation == 4 {
                                                Image("SuperShayan4")
                                                    .resizable()
                                                    .frame(width: 300, height: 450)
                                                    .shadow(color: .orange, radius: 15, x: 0, y: 0)
                                                    .padding(.top, 10)
                                            } else {
                                                AsyncImage(url: URL(string: selectedTransformation.image)) { image in
                                                    image
                                                        .resizable()
                                                        .scaledToFit()
                                                } placeholder: {
                                                    ProgressView()
                                                }
                                                .frame(height: 450)
                                                .shadow(color: .orange, radius: 15, x: 0, y: 0)
                                                .padding(.top, 10)
                                            }
                                        }
                                    
                            
                            Picker(" ", selection: $idTranformation){
                                ForEach(character.transformations, id: \.id){ item in
                                    Text( item.ki).tag(item.id)
                                }
                            } .pickerStyle(.palette).padding()
                                .font(.custom("SaiyanSans", size: 40)).shadow(color: .blue , radius: 15, x: 0, y: 0 )
                        }
                    }
                    
               // }
                
            }.padding()
        }.modifier(StyleColorDegrader(isColor: .gray, isColor2: .black))
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
    let selectedCharacter = Character(id: 1, name: "Goku", ki: "60.000.000", maxKi: "90 Septillion", race: "Saiyan", gender: "Male", description: "El protagonista de la serie, conocido por su gran poder y personalidad amigable. Originalmente enviado a la Tierra como un infante volador con la misión de conquistarla. Sin embargo, el caer por un barranco le proporcionó un brutal golpe que si bien casi lo mata, este alteró su memoria y anuló todos los instintos violentos de su especie, lo que lo hizo crecer con un corazón puro y bondadoso, pero conservando todos los poderes de su raza. No obstante, en la nueva continuidad de Dragon Ball se establece que él fue enviado por sus padres a la Tierra con el objetivo de sobrevivir a toda costa a la destrucción de su planeta por parte de Freeza. Más tarde, Kakarot, ahora conocido como Son Goku, se convertiría en el príncipe consorte del monte Fry-pan y líder de los Guerreros Z, así como el mayor defensor de la Tierra y del Universo 7, logrando mantenerlos a salvo de la destrucción en innumerables ocasiones, a pesar de no considerarse a sí mismo como un héroe o salvador.", image: "https://res.cloudinary.com/dgtgbyo76/image/upload/v1699044374/hlpy6q013uw3itl5jzic.webp", affiliation: "Z Fighter", deletedAt: nil)
    
    return DetailsView(selectedCharacter: selectedCharacter)
}

extension DetailsView {

}

