//
//  HomeViewModel.swift
//  DrgonBollWiki
//
//  Created by Jacob Aguilar on 03-03-24.
//

import Foundation

@Observable
class HomeViewModel {
    private let allCaractersDataService: AllCharactersProtocol
    var allCharacters: Characters?
    var isLoading: Bool = false
    var showErrorMessage: Bool = false
    var errorMessage: String = ""
    
    init(allCaractersDataService: AllCharactersProtocol) {
        self.allCaractersDataService = allCaractersDataService
        
        Task {
            await getAllCharacters()
        }
    }
    
    @MainActor
    func getAllCharacters() async {
        do {
            allCharacters = try await allCaractersDataService.getCharacters()
        } catch {
            print(error)
            errorMessage = "Error al intentar obtener los datos del servidor"
            showErrorMessage.toggle()
        }
    }
}
