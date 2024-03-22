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
        .init(title: "Dragon Ball", imageCoves: "DragonBall_CD"),
        .init(title: "Dragon Ball Z", imageCoves: "DragonBallZ_CD"),
        .init(title: "Dragon Ball GT", imageCoves: "DragonBallGT_CD"),
        .init(title: "DragonBall Super", imageCoves: "DragonBallSuper_CD"),
        .init(title: "Dragon Ball Z Kai", imageCoves: "DragonBallKai_CD")
    ]
}
