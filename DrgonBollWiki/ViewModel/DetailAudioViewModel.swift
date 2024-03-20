//
//  DetailAudioViewModel.swift
//  DrgonBollWiki
//
//  Created by Esteban Perez Castillejo on 19/3/24.
//

import Foundation
import AVFAudio


enum PlayStatus {
    case play
    case pause
    case stop
}

@Observable
class DetailAudioViewModel{
    
    
    //Audio player
    var audioPlayer: AVAudioPlayer?
    var time: Double = 0.0
    var currentTime: TimeInterval = 0
    var isPlay = false
    
    /// Función de reproducción
    func playAudio(_ url: String){
        guard let audioData = Bundle.main.url(forResource: url , withExtension: "mp3") else {
            print("audios no disponibles")
            return
        }
        
            audioPlayer = try! AVAudioPlayer(contentsOf: audioData)
            audioPlayer?.currentTime = time
            audioPlayer?.prepareToPlay()
            audioPlayer?.play()
            isPlay = true
            print("reproduciendo audio ...")
        
    }
    
    /// Pausar el audio
    func pauseAudio() {
        audioPlayer?.pause()
        time = audioPlayer?.currentTime ?? 0.0
        isPlay = false
        print("Audio pausado")
    }
    
    /// Parar ell audio
    func stopAudio(){
        time = 0.0
        audioPlayer?.prepareToPlay()
        audioPlayer?.stop()
        isPlay = false
        print("Audio Detenido")
    }
    
    
}
