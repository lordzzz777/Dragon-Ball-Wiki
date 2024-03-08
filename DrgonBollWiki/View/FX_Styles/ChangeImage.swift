//
//  ChangeImage.swift
//  DrgonBollWiki
//
//  Created by Esteban Perez Castillejo on 8/3/24.
//

import SwiftUI

struct ChangeImage: View {
    @State private var singleCharacterViewModel: SingleCharacterViewModel
    var characterId: Int
    @State var isBool: Bool
    init(singleCharactersDataService: SingleCharacterProtocol, characterId: Int, isBool: Bool) {
        _singleCharacterViewModel = State(wrappedValue: SingleCharacterViewModel(singleCharacterDataService: singleCharactersDataService))
        self.characterId = characterId
        self.isBool = isBool
    }
    
    var body: some View {
     
        if characterId == singleCharacterViewModel.character?.id && confirme( isBool){
            AsyncImage(url: URL(string: singleCharacterViewModel.character?.image ?? "")) { image in
                image.resizable()
                    .scaledToFit()
            } placeholder: {
                ProgressView()
            }
        }else {
            
        }
   
  
    }
    
    func confirme(_ bool: Bool) -> Bool {
        return bool
    }
}


#Preview {
    DetailsView(singleCharactersDataService: MockSingleCharacterDataService(testData: nil), characterId: 1)
}
