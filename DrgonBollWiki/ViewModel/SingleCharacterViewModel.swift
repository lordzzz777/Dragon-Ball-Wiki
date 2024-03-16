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
    private let singleCharacterDataService: SingleCharacterDataService
    
    var character: SingleCharacter?
    var selectedCharacter: Character?
    var selectedCharacterKiColor: Color = .yellow
    var isLoading: Bool = false
    var showErrorMessage: Bool = false
    var errorMessage: String = ""
    
    init(singleCharacterDataService: SingleCharacterDataService) {
        self.singleCharacterDataService = singleCharacterDataService
    }
    
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
    
    func getKiColor(character: Character) {
        switch character.race {
        case "Evil":
            selectedCharacterKiColor = .black
        case "Android":
            selectedCharacterKiColor = .cyan
        case "Majin":
            selectedCharacterKiColor = .pink
        case "Nucleico":
            selectedCharacterKiColor = .white
        case "Namekian":
            selectedCharacterKiColor = .green
        case "Saiyan":
            selectedCharacterKiColor = .yellow
        case "Jiren Race":
            selectedCharacterKiColor = .red
        case "Frieza Race":
            selectedCharacterKiColor = .gray
        case "Nucleico benigno":
            selectedCharacterKiColor = .brown
        case "Human":
            selectedCharacterKiColor = .blue
        case "Angel":
            selectedCharacterKiColor = .mint
        case "God":
            selectedCharacterKiColor = .indigo
        case "Unknown":
            selectedCharacterKiColor = .white
        default:
            selectedCharacterKiColor = .white
        }
    }
}
