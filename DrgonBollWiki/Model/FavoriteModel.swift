//
//  DbSwiftDataModel.swift
//  DrgonBollWiki
//
//  Created by Esteban Perez Castillejo on 7/3/24.
//

import Foundation
import SwiftData
import SwiftUI

@Model
class FavoriteModel {
    var idFavorites: String
    var id: Int
    var orden: Int
    var isFavorites: Bool
   
    
    init(idFavorites: String = UUID().uuidString, id: Int, orden: Int = 0, isFavorites: Bool) {
        self.idFavorites = idFavorites
        self.id = id
        self.orden = orden
        self.isFavorites = isFavorites
       
    }
}
