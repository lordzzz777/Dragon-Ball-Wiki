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
    private let allCaractersDataService: AllCharactersProtocol
    var allCharacters: Characters?
    var isLoading: Bool = false
    var showErrorMessage: Bool = false
    var errorMessage: String = ""
    
    //Audio player
    private var audioPlayer: AVAudioPlayer?
    var isPlaying = false
    
    
    init(allCaractersDataService: AllCharactersProtocol) {
        self.allCaractersDataService = allCaractersDataService
        
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
    
    func playCardSound() {
        guard let player = audioPlayer else { return }
        
        player.play()
    }
}
