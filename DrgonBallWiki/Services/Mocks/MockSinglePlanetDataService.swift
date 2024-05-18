//
//  MockSinglePlanetDataService.swift
//  DrgonBollWiki
//
//  Created by Jacob Aguilar on 03-03-24.
//

import Foundation

class MockSinglePlanetDataService: SinglePlanetProtocol {
    let testData: SinglePlanet
    
    init(testData: SinglePlanet?) {
        self.testData = testData ?? SinglePlanet(
            id: 1, name: "Namek",
            isDestroyed: true,
            description: "Planeta natal de los Namekianos. Escenario de importantes batallas y la obtención de las Dragon Balls de Namek.",
            image:  "https://res.cloudinary.com/dgtgbyo76/image/upload/v1699145134/wxedvvh8kiyw00psvphl.webp",
            deletedAt: nil,
            characters: [
                Character(
                    id: 1,
                    name: "Goku",
                    ki: "60.000.000",
                    maxKi: "90 Septillion",
                    race: "Saiyan",
                    gender: "Male",
                    description: "El protagonista de la serie, conocido por su gran poder y personalidad amigable. Originalmente enviado a la Tierra como un infante volador con la misión de conquistarla. Sin embargo, el caer por un barranco le proporcionó un brutal golpe que si bien casi lo mata, este alteró su memoria y anuló todos los instintos violentos de su especie, lo que lo hizo crecer con un corazón puro y bondadoso, pero conservando todos los poderes de su raza. No obstante, en la nueva continuidad de Dragon Ball se establece que él fue enviado por sus padres a la Tierra con el objetivo de sobrevivir a toda costa a la destrucción de su planeta por parte de Freeza. Más tarde, Kakarot, ahora conocido como Son Goku, se convertiría en el príncipe consorte del monte Fry-pan y líder de los Guerreros Z, así como el mayor defensor de la Tierra y del Universo 7, logrando mantenerlos a salvo de la destrucción en innumerables ocasiones, a pesar de no considerarse a sí mismo como un héroe o salvador.",
                    image:  "https://res.cloudinary.com/dgtgbyo76/image/upload/v1699044374/hlpy6q013uw3itl5jzic.webp",
                    affiliation: "Z Fighter",
                    deletedAt: nil
                ),
                Character(
                    id: 3,
                    name: "Piccolo",
                    ki: "2.000.000",
                    maxKi: "500.000.000",
                    race: "Namekian",
                    gender: "Male",
                    description: "Es un namekiano que surgió tras ser creado en los últimos momentos de vida de su padre, siendo su...",
                    image: "https://res.cloudinary.com/dgtgbyo76/image/upload/v1699044481/u9fhpc9smihu2kud3cuc.webp",
                    affiliation: "Namekian",
                    deletedAt: nil
                )
            ]
        )
    }
    
    func getSinglePlanet(id: Int) async throws -> SinglePlanet {
        return testData
    }
}
