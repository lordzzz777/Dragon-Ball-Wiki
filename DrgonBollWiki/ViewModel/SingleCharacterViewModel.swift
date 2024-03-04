//
//  SingleCharacterViewModel.swift
//  DrgonBollWiki
//
//  Created by Jacob Aguilar on 03-03-24.
//

import Foundation

@Observable
class SingleCharacterViewModel {
    private let singleCharacterDataService: SingleCharacterProtocol
    
    var character: SingleCharacter?
    var isLoading: Bool = false
    var showErrorMessage: Bool = false
    var errorMessage: String = ""
    
    init(singleCharacterDataService: SingleCharacterProtocol) {
        self.singleCharacterDataService = singleCharacterDataService
    }
    
    @MainActor
    func getCharacterInformation(characterID id: Int) async {
        do {
            character = try await singleCharacterDataService.getSingleCharacter(id: id)
            if let character = character {
                print("Se obtuvo la información del personaje: \(character.name)")
            }
        } catch {
            print(error)
            errorMessage = "Error al intentar obtener los datos del personaje desde el servidor"
            showErrorMessage.toggle()
        }
    }
}
