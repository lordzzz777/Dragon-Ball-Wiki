//
//  CardPlanetView.swift
//  DrgonBollWiki
//
//  Created by Esteban Perez Castillejo on 27/3/24.
//

import SwiftUI

struct CardPlanetView: View {
    
    let planet: Planet
    let isShadowVisible: Bool = true
    
    var cornerRadius: CGFloat = 20
 
    init(planet: Planet) {
        self.planet = planet
    }
    
    var body: some View {
        HStack{
            VStack(alignment: .leading, spacing: 10){
                Spacer().frame(height: 10)
                Text(planet.name)
                    .modifier(StyleViewFont(size: 40, color: .red))
                    .fontWeight(.bold)
              Spacer()
                
            }
           Spacer()
        }
        .padding()
        .foregroundStyle(.white)
        .background(
            AsyncImage(url: URL(string: planet.image)) { image in
                image.resizable()
                    .aspectRatio(contentMode: .fit)
            } placeholder: {
                ProgressView()
            }
                .aspectRatio(contentMode: .fill)
                .brightness(-0.15)
                .clipped()
        )
        .cornerRadius(cornerRadius)
        .shadow(radius: 10)
        
    }
}

#Preview {
    let planet = Planet(id: 1, name: "Namek", isDestroyed: true, description: "Planeta natal de los Namekianos. Escenario de importantes batallas y la obtención de las Dragon Balls de Namek.", image: "https://res.cloudinary.com/dgtgbyo76/image/upload/v1699145134/wxedvvh8kiyw00psvphl.webp", deletedAt: nil)
    return CardPlanetView(planet:  planet)
}
