//
//  SingleCharacterViewModel.swift
//  DrgonBollWiki
//
//  Created by Jacob Aguilar on 03-03-24.
//

import Foundation
import SwiftUI

@Observable
class SingleCharacterViewModel {
    private let singleCharacterDataService: SingleCharacterDataService = SingleCharacterDataService()
    
    var character: SingleCharacter?
    var selectedCharacter: Character?
    var isLoading: Bool = false
    var showErrorMessage: Bool = false
    var errorMessage: String = ""
    
    ///Obtiene la información de un personaje a través de su ID y lo almacena en la propiedad `character` de la clase `SingleCharacterViewModel`
    /// - Parameters: `id: Int`
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
