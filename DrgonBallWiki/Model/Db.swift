//
//  Db.swift
//  DrgonBollWiki
//
//  Created by Esteban Perez Castillejo on 3/3/24.
//

import Foundation
import SwiftData

@Model
class Db {
    
    var id: String
    var name: String
    @Relationship() var Db2
    init(id: String, name: String) {
        self.id = id
        self.name = name
    }
}

class Db2 {
    
    var id: String
    var name: String
    
    init(id: String, name: String) {
        self.id = id
        self.name = name
    }
}

