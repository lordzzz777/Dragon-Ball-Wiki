//
//   DetailsView.swift
//  DrgonBollWiki
//
//  Created by Esteban Perez Castillejo on 4/3/24.
//

import SwiftUI

struct DetailsView: View {
    @State private var singleCharacterViewModel: SingleCharacterViewModel
    var characterId: Int
    
    init(singleCharactersDataService: SingleCharacterProtocol, characterId: Int) {
        _singleCharacterViewModel = State(wrappedValue: SingleCharacterViewModel(singleCharacterDataService: singleCharactersDataService))
        self.characterId = characterId
    }
   
    
    var body: some View {
        ScrollView{
            VStack(alignment: .leading){
              
                Text(singleCharacterViewModel.character?.name ?? "").task {
                    await singleCharacterViewModel.getCharacterInformation(characterID: characterId )
                }.font(.custom("Saiyan.ttf", size: 40)).padding(.horizontal, 100).bold()
                Divider()
                Text(singleCharacterViewModel.character?.description ?? "").task {
                    await singleCharacterViewModel.getCharacterInformation(characterID: characterId )
                }
                Divider()
                Text(singleCharacterViewModel.character?.originPlanet.description ?? "").task {
                    await singleCharacterViewModel.getCharacterInformation(characterID: characterId )
                }
               
            }.padding()
          
        }
    }
   
}

#Preview {
    DetailsView(singleCharactersDataService: MockSingleCharacterDataService(testData: nil), characterId: 1)
}

extension DetailsView {

}

