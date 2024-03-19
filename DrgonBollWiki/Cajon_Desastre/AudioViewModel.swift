//
//  AudioViewModel.swift
//  DrgonBollWiki
//
//  Created by Esteban Perez Castillejo on 18/3/24.
//

import Foundation
import AVFAudio

class AudioViewModel {
    var audioPlayerMusic: [PlayList: AVAudioPlayer] = [:] // Almacena AVAudioPlayer con el nombre del archivo como clave
    private let audioFolder = "Miusic" // Quita la ruta absoluta, solo necesitas el nombre de la carpeta
    
    var orden: Int = 0 // Controla el orden de reproducción
    var time: Double = 0.0 // Marca el tiempo de reproducción
    var currentTime: TimeInterval = 0 // En qué parte de tiempo se encuentra la reproducción
    var totalTime: TimeInterval = 0 // Duración de la reproducción
    var timer: Timer? // Se instancia la clase de tiempo
    
    var isPlayingMusic = false
    
    init() {
        Task {
//            if let audioFoldeURLs = Bundle.main.urls(forResourcesWithExtension: "mp3", subdirectory: audioFolder) {
//                for fileURL in audioFoldeURLs {
//                    let fileName = fileURL.lastPathComponent
//                    do {
//                        let audioPlayer = try AVAudioPlayer(contentsOf: fileURL)
//                        audioPlayer.prepareToPlay() // Prepara el reproductor de audio para reproducir
//                        audioPlayerMusic[fileName] = audioPlayer // Usa el nombre del archivo como clave
//                    } catch {
//                        print("Error al cargar los archivos de audio \(fileName): ->", error.localizedDescription)
//                    }
//                }
//            } else {
//                print("No encontró los archivos de audio")
//            }
            do{
                if let audioFoldeURL = Bundle.main.url(forResource: audioFolder, withExtension: "mp3"){
                    let audioFolderURLs = try FileManager.default.contentsOfDirectory(at: audioFoldeURL, includingPropertiesForKeys: nil)
                    for fileURL in audioFolderURLs {
                        let filename = fileURL.lastPathComponent
                        if let audiPlayr = try? AVAudioPlayer(contentsOf: fileURL){
                            audioPlayerMusic[PlayList(id: UUID() , title: filename)] = audiPlayr
                        } else {
                            print("Error al cargar el archivo de audio \(filename)")
                        }
                    }
                }
            }catch{
                print("Error al cargar los audios -> ", error.localizedDescription)
            }
            
            // Observar el tiempo trascurrido utilizando un temporizador
            Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
                if let audioPlayer = self.audioPlayerMusic.first?.value {
                    self.currentTime = audioPlayer.currentTime
                    self.totalTime = audioPlayer.duration
                }
            }
        }
    }
   
    /// Reanudar reproducción
    func resumeAudio() {
        guard let audioData = audioPlayerMusic.values.first else { return } // Obtén el primer AVAudioPlayer
        
        audioData.play()
        isPlayingMusic = true // Debes cambiar esto a true si estás reanudando la reproducción
    }
    
    /// Función que muestre formato de tiempo
    func formatTime(_ time: TimeInterval) -> String {
        let minutes = Int(time) / 60
        let seconds = Int(time) % 60
        
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    /// Función de pausa
    func pauseAudioMusic() {
        guard let audioData = audioPlayerMusic.values.first else { return } // Obtén el primer AVAudioPlayer
        
        audioData.pause()
        isPlayingMusic = false // Debes cambiar esto a false si estás pausando la reproducción
        print("Pausar audio ...")
    }
    
    func stopAudio() {
        guard let audioData = audioPlayerMusic.values.first else {
            print("Audios no disponibles")
            return
        }
        
        audioData.stop()
        totalTime = 0
        isPlayingMusic = false // Debes cambiar esto a false si estás deteniendo la reproducción
        print("Detener audio ...")
    }
}
