//
//  MockPlanetsDataServcice.swift
//  DrgonBollWiki
//
//  Created by Jacob Aguilar on 03-03-24.
//

import Foundation

class MockPlanetsDataServcice: PlanetsProtocol {
    let testData: Planets
    
    init(testData: Planets?) {
        self.testData = testData ?? Planets(items: [Planet(id: 1, name: "Namek", isDestroyed: true, description: "Planeta natal de los Namekianos. Escenario de importantes batallas y la obtención de las Dragon Balls de Namek.", image: "https://res.cloudinary.com/dgtgbyo76/image/upload/v1699145134/wxedvvh8kiyw00psvphl.webp", deletedAt: nil), Planet(id: 2, name: "Tierra", isDestroyed: false, description: "La Tierra también llamado Mundo del Dragón (Dragon World), es el planeta principal donde se desarrolla la serie de Dragon Ball. Se encuentra en el Sistema Solar de la Vía Láctea de las Galaxias del Norte del Universo 7, lugar que supervisa el Kaio del Norte, y tiene su equivalente en el Universo 6. El hogar de los terrícolas y los Guerreros Z. Ha sido atacado en varias ocasiones por enemigos poderosos.", image:  "https://res.cloudinary.com/dgtgbyo76/image/upload/v1699145184/yq8zw7kk4fmhgyj4z0c7.webp", deletedAt: nil)], meta: Meta(totalItems: 1, itemCount: 1, itemsPerPage: 1, totalPages: 1, currentPage: 1), links: Links(first: "", previous: "", next: "", last: ""))
    }
    
    func getPlanets() async throws -> Planets {
        return testData
    }
    
}
