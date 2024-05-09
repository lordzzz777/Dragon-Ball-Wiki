//
//  CardLisOlaneteView2.swift
//  DrgonBollWiki
//
//  Created by Esteban Perez Castillejo on 2/4/24.
//

import SwiftUI

struct CardListPlanetesView2: View {
    
    @State private var selectedPlanet: Planet? = nil
    @State private var isAnimating = false
    
    @Namespace var namespace
    
    let planets: Planets
    let columns = [GridItem(.flexible(minimum: 100)), GridItem(.flexible())]
    init(planets: Planets) {
        self.planets = planets
    }
    
    var body: some View {
        ZStack{
            //MARK: Card View
            VStack(alignment: .leading, spacing: 20){
                ScrollView{
                    LazyVGrid(columns: columns, spacing: 11){
                        ForEach(planets.items, id:\.id){ planet in
                            if planet.id != selectedPlanet?.id {
                                VStack{
                                    CardPlanetView(planet: planet)
                                        .matchedGeometryEffect(id: planet.id, in: namespace)
                                        .frame(width: 130, height: 130, alignment: .center)
                                        .onTapGesture {
                                            withAnimation(.spring()){
                                                selectedPlanet = planet
                                                isAnimating = true
                                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                                                    isAnimating = false
                                                }
                                            }
                                        }
                                        .disabled(isAnimating)
                                }
                                .matchedGeometryEffect(id: "container \(planet.id)", in: namespace)
                            }else {
                                Color.clear.frame(width: 330, height: 250)
                            }
                        }
                    }
                }
            }
            .zIndex(1)
            
            // MARK: Detain Card
            if let selectedPlanet = selectedPlanet{
                VStack{
                    ScrollView(.vertical, showsIndicators: true){
                        CardPlanetView(planet: selectedPlanet)
                            .matchedGeometryEffect(id: selectedPlanet.id, in: namespace)
                            .frame(height: 300)
                            .onTapGesture {
                                withAnimation(.spring()){
                                    self.selectedPlanet = nil
                                    isAnimating = true
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                                        isAnimating = false
                                    }
                                }
                            }
                            .disabled(isAnimating)
                        Text(selectedPlanet.description).foregroundStyle(Color.white)
                            .shadow(color: .black, radius: 5)
                            .padding()
                    }
                    .background(Color.orange.opacity(0.8))
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .shadow(radius: 10)
                    .matchedGeometryEffect(id: "Container\(selectedPlanet.id)", in: namespace)
                    .edgesIgnoringSafeArea(.all)
                    .transition(.hero)
                }
                .zIndex(2)
            }
        }
        
    }
}

#Preview {
    let planets = Planets(items: [Planet(id: 1, name: "Namek", isDestroyed: true, description: "Planeta natal de los Namekianos. Escenario de importantes batallas y la obtención de las Dragon Balls de Namek.", image: "https://dragonball-api.com/planetas/Namek_U7.webp", deletedAt: nil), Planet(id: 2, name: "Tierra", isDestroyed: false, description:  "La Tierra también llamado Mundo del Dragón (Dragon World), es el planeta principal donde se desarrolla la serie de Dragon Ball. Se encuentra en el Sistema Solar de la Vía Láctea de las Galaxias del Norte del Universo 7, lugar que supervisa el Kaio del Norte, y tiene su equivalente en el Universo 6. El hogar de los terrícolas y los Guerreros Z. Ha sido atacado en varias ocasiones por enemigos poderosos.", image: "https://dragonball-api.com/planetas/Tierra_Dragon_Ball_Z.webp", deletedAt: nil), Planet(id: 3, name: "Vejeta", isDestroyed: false, description: "La Tierra también llamado Mundo del Dragón (Dragon World), es el planeta principal donde se desarrolla la serie de Dragon Ball. Se encuentra en el Sistema Solar de la Vía Láctea de las Galaxias del Norte del Universo 7, lugar que supervisa el Kaio del Norte, y tiene su equivalente en el Universo 6. El hogar de los terrícolas y los Guerreros Z. Ha sido atacado en varias ocasiones por enemigos poderosos.", image:  "https://dragonball-api.com/planetas/Planeta_Vegeta_en_Dragon_Ball_Super_Broly.webp", deletedAt: nil) ], meta: Meta(totalItems: 1, itemCount: 1, itemsPerPage: 1, totalPages: 1, currentPage: 1), links: Links(first: "", previous: "", next: "", last: ""))
    return  CardListPlanetesView2(planets: planets)
}
