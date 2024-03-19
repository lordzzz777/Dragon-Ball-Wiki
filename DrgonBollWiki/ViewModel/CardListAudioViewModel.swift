//
//  CardListAudioViewModel.swift
//  DrgonBollWiki
//
//  Created by Esteban Perez Castillejo on 19/3/24.
//

import Foundation

@Observable
class CardListAudioViewModel {
    
    let arrayOfSounds: [PlayList] = [
        .init(title: "01_DragonBall"),
        .init(title: "02_DragonBallZ"),
        .init(title: "03_DragonBallGT"),
        .init(title: "04_DragonBallSuper"),
        .init(title: "05_DragonBallZKai")
    ]
    
}
