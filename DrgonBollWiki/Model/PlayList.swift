//
//  PlayList.swift
//  DrgonBollWiki
//
//  Created by Esteban Perez Castillejo on 17/3/24.
//

import Foundation

struct PlayList: Hashable, Codable {
    var id: UUID
    var title: String
    
    func getURL() -> URL{
        return URL(string: Bundle.main.path(forResource: title, ofType: "mp3")!)!
    }
}

let arrayOfSounds: [PlayList] = [
    .init(id: UUID(), title: "01_DragonBall"),
    .init(id: UUID(), title: "02_DragonBallZ"),
    .init(id: UUID(), title: "03_DragonBallGT"),
    .init(id: UUID(), title: "04_DragonBallSuper"),
    .init(id: UUID(), title: "05_DragonBallZKai")
]
