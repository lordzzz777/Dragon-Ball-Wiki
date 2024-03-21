//
//  HomeViewModel.swift
//  DrgonBollWiki
//
//  Created by Jacob Aguilar on 03-03-24.
//

import Foundation
import AVFoundation



@Observable
class HomeViewModel {
    private let allCaractersDataService: AllCharactersDataService = AllCharactersDataService()
    var allCharacters: [Character] = []
    var searchedCharacters: [Character] = []
    var isLoading: Bool = false
    var showErrorMessage: Bool = false
    var errorMessage: String = ""
    
    //Audio player
    private var audioPlayer: AVAudioPlayer?
    var time: Double = 0.0
    var currentTime: TimeInterval = 0
    var isPlaying = false
   
    
    
    init() {
        Task {
            //Obteniendo el archivo de audio para el giro de las cards
            if let sound = Bundle.main.path(forResource: "cardFx03", ofType: "mp3") {
                do {
                    self.audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound))
                } catch {
                    print("Error al cargar el archivo de audio: -> ", error.localizedDescription)
                }
            } else {
                print("No se pudo cargar el archivo de audio")
            }
            
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
    
    ///Permite reproducir el audio de giro de una card
    func playCardSound() {
        guard let player = audioPlayer else { return }
        
        player.play()
    }
    
    /// Permite que el usuaria cambie entre la vista de cartas y la de carrusel ...
    func liveScrol(_ index: Int) -> Bool {
        switch index {
        case 1:
           return true
        case 2:
            return false
        default:
            return false
        }
    }
}
