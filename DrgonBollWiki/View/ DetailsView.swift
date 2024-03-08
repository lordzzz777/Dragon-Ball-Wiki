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
    
   
    
   // @Binding var characterId: Int?
     
    var body: some View {
        Text(singleCharacterViewModel.character?.name ?? "").task {
            await singleCharacterViewModel.getCharacterInformation(characterID: characterId )
        }
    }
   
}

#Preview {
    DetailsView(singleCharactersDataService: MockSingleCharacterDataService(testData: nil), characterId: 1)
}

extension DetailsView {

}

/*
 struct DetailsView: View {
     @State private var singleCharacterViewModel: SingleCharacterViewModel
      var characterId: Int?
     
     init(singleCharactersDataService: SingleCharacterProtocol) {
         _singleCharacterViewModel = State(wrappedValue: SingleCharacterViewModel(singleCharacterDataService: singleCharactersDataService))
         
         }
     
    // @Binding var characterId: Int?
      
     var body: some View {
         Text(singleCharacterViewModel.character?.name ?? "").task {
             if let id = characterId {
                 await singleCharacterViewModel.getCharacterInformation(characterID: id )
             }
             
         }
     }
 }

 #Preview {
     DetailsView(singleCharactersDataService: MockSingleCharacterDataService(testData: nil))
 }
 */
