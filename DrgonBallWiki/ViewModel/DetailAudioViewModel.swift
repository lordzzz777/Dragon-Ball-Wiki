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
final class DetailAudioViewModel: NSObject {

    var showStatus = false
    var statusButtonStop = false
    var mostrarButtonMnu = true

    //Audio player
    private var audioPlayer: AVAudioPlayer?
    private var isPlay = false

    var title: String
    var cover: String

    var totalTime: TimeInterval = .zero
    var currentTime: TimeInterval = .zero

    init(title: String, cover: String) {
        self.title = title
        self.cover = cover

        super.init()
        setupAudio()
    }

    func tooglePlayback(for audio: PlayStatus) {
        switch audio {
        case .play:
            playAudio()
        case .pause:
            pauseAudio()
        case .stop:
            stopAudio()
        }
    }

    func updateProgress() {
        guard let audioPlayer else { return }

        currentTime = audioPlayer.currentTime
    }

    func updateAudioPlayerTime() {
        audioPlayer?.currentTime = currentTime
    }

    func timeString(time: TimeInterval) -> String {
        let minute = Int(time) / 60
        let seconds = Int(time) % 60

        return String(format: "%02d:%02d", minute, seconds)
    }

    func sliderEditingChanged(editingStarted: Bool) {
        guard !editingStarted else { return }

        audioPlayer?.currentTime = currentTime
    }
}

// MARK: - Private Methods

private extension DetailAudioViewModel {

    func setupAudio() {
        guard let url = Bundle.main.url(forResource: title, withExtension: "mp3") else { return }

        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.prepareToPlay()
            audioPlayer?.delegate = self
            totalTime = audioPlayer?.duration ?? .zero
        } catch {
            print("Error loading audio: \(error)")
        }
    }

    /// Función de reproducción
    func playAudio() {
        audioPlayer?.play()
        isPlay = true

        print("reproduciendo audio ...")
    }

    /// Pausar el audio
    func pauseAudio() {
        audioPlayer?.pause()
        isPlay = false

        print("Audio pausado")
    }

    /// Parar el audio
    func stopAudio() {
        audioPlayer?.stop()

        currentTime = .zero
        audioPlayer?.currentTime = .zero
        isPlay = false
        showStatus = false

        print("Audio Detenido")
    }
}

// MARK: - AV Audio Player Delegate

extension DetailAudioViewModel: AVAudioPlayerDelegate {

    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        stopAudio()
    }
}
