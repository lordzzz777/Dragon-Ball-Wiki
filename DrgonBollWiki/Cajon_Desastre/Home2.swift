//
//  Home2.swift
//  DrgonBollWiki
//
//  Created by Esteban Perez Castillejo on 3/3/24.
//

import SwiftUI

//Vista pra pribar que la API Funciona
struct Home2: View {
    @State private var homeViewModel = HomeViewModel()
    @State private var planetsViewModel = PlanetsViewModel(planetsDataSevice: PlanetsDataService())
    @State private var selectedCharacter: Character?
    @State private var selectedPlanets: Planets?
    
    @State private var isLoading = false
    
    var body: some View {
        NavigationStack{
            VStack{
                if isLoading{
                    ProgressView()
                }else if let characters = homeViewModel.allCharacters {
                    List(characters.items, id:\.id){ character in
                            VStack(alignment: .leading){
                                AsyncImage(url: URL(string: character.image)) { image in
                                    image.resizable()
                                        .aspectRatio(contentMode: .fit)
                                } placeholder: {
                                    ProgressView()
                                }
                            .frame(width: 100, height: 100)
                            Text(character.name).font(.title)
                            Text(character.description)
                            Text(character.race)
                            Text(character.affiliation)
                            Text(character.gender)
                            Text(character.ki)
                            Text(character.maxKi)
                        }
                    }
                }else{
                    Text("No cherate available")
                }
                
                if isLoading{
                    ProgressView()
                }else if let planets = planetsViewModel.allPlanets{
                    List(planets.items, id: \.id){planet in
                        HStack{
                            AsyncImage(url: URL(string: planet.image)){ image in
                                image.resizable()
                                    .aspectRatio(contentMode: .fit)
                            } placeholder: {
                                ProgressView()
                            }.frame(width: 100, height: 100)
                            Text(planet.name)
                        }
                    }
                }
            }
        }.navigationTitle("Dragon Ball Charaters")
    }
}

#Preview {
    Home2()
}
