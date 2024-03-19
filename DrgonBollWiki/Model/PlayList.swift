//
//  PlayList.swift
//  DrgonBollWiki
//
//  Created by Esteban Perez Castillejo on 17/3/24.
//

import Foundation

struct PlayList: Hashable {
    var title: String
    
    func getURL() -> URL{
        return URL(string: Bundle.main.path(forResource: title, ofType: "mp3")!)!
    }
}


