//
//  ContentView.swift
//  DrgonBollWiki
//
//  Created by Grupo de Estudio on 1/3/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        AllCharactersView(allCaractersDataService: AllCharactersDataService(), planetsDataSevice: PlanetsDataService(), dbSwiftDataModel: [], dbSwiftDataViewModel: FavoritesViewModel())
    }
}

#Preview {
    ContentView()
}
