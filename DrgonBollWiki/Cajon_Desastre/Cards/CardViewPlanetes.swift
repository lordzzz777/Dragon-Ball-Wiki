//
//  CardViewPlanetes.swift
//  DrgonBollWiki
//
//  Created by Esteban Perez Castillejo on 17/3/24.
//

import SwiftUI

struct CardViewPlanetes: View {
    
    let planetes: Planet
    
    init(planetes: Planet) {
        self.planetes = planetes
    }
    
    
    var body: some View {
        Text(planetes.name)
    }
}

