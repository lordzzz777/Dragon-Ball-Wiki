//
//  HomeViewModel.swift
//  DrgonBollWiki
//
//  Created by Jacob Aguilar on 03-03-24.
//

import Foundation
import AVFoundation

@Observable
class AllCharactersViewModel {
    
    private let allCaractersDataService: AllCharactersDataService = AllCharactersDataService()
    var allCharacters: [Character] = []
    var searchedCharacters: [Character] = []
    var isLoading: Bool = false
    var showErrorMessage: Bool = false
    var errorMessage: String = ""

    init() {
        Task {
            await getAllCharacters()
        }
    }
    
    ///Obtiene todos los caracteres y los almancena en la propiedad `allCharacters` de la clase `HomeViewModel`
    @MainActor
    func getAllCharacters() async {
        do {
            allCharacters = try await allCaractersDataService.getCharacters().items
        } catch {
            print(error)
            errorMessage = "Error al intentar obtener los datos del servidor"
            showErrorMessage.toggle()
        }
    }
    
    ///Permite buscar un personaje por el nombre y lo guarda en la propiedad `searchedCharacters` qué es un array de Character del la clase `HomeViewModel`
    func searchCharacter(characterName name: String) {
        searchedCharacters = allCharacters.filter({ $0.name.contains(name) })
    }
}
