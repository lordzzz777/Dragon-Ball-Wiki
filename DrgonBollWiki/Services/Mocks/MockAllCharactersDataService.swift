//
//  MockAllCharactersDataService.swift
//  DrgonBollWiki
//
//  Created by Jacob Aguilar on 03-03-24.
//

import Foundation


class MockAllCharactersDataService: AllCharactersProtocol {
    
    let testData: Characters
    
    //Esto nos permite iniciar con datos falsos si es que queremos o no
    init(testData: Characters?) {
        self.testData = testData ?? Characters(items: [
            Character(id: 1, name: "Goku", ki: "60.000.000", maxKi: "90 Septillion", race: "Saiyan", gender: "Male", description: "El protagonista de la serie, conocido por su gran poder y personalidad amigable. Originalmente enviado a la Tierra como un infante volador con la misión de conquistarla. Sin embargo, el caer por un barranco le proporcionó un brutal golpe que si bien casi lo mata, este alteró su memoria y anuló todos los instintos violentos de su especie, lo que lo hizo crecer con un corazón puro y bondadoso, pero conservando todos los poderes de su raza. No obstante, en la nueva continuidad de Dragon Ball se establece que él fue enviado por sus padres a la Tierra con el objetivo de sobrevivir a toda costa a la destrucción de su planeta por parte de Freeza. Más tarde, Kakarot, ahora conocido como Son Goku, se convertiría en el príncipe consorte del monte Fry-pan y líder de los Guerreros Z, así como el mayor defensor de la Tierra y del Universo 7, logrando mantenerlos a salvo de la destrucción en innumerables ocasiones, a pesar de no considerarse a sí mismo como un héroe o salvador.", image: "https://res.cloudinary.com/dgtgbyo76/image/upload/v1699044374/hlpy6q013uw3itl5jzic.webp", affiliation: "Z Fighter", deletedAt: nil), Character(id: 2, name: "Vegeta", ki: "54.000.000", maxKi: "19.84 Septillion", race: "Saiyan", gender: "Male", description: "Príncipe de los Saiyans, inicialmente un villano, pero luego se une a los Z Fighters. A pesar de que a inicios de Dragon Ball Z, Vegeta cumple un papel antagónico, poco después decide rebelarse ante el Imperio de Freeza, volviéndose un aliado clave para los Guerreros Z. Con el paso del tiempo llegaría a cambiar su manera de ser, optando por permanecer y vivir en la Tierra para luchar a su lado contra las inminentes adversidades que superar. Junto con Piccolo, él es de los antiguos enemigos de Goku que ha evolucionando al pasar de ser un villano y antihéroe, a finalmente un héroe a lo largo del transcurso de la historia, convirtiéndose así en el deuteragonista de la serie.", image: "http://dragonball-api.com/characters/vegeta_normal.webp", affiliation: "Z Fighter", deletedAt: nil), Character(id: 3, name: "Goku", ki: "60.000.000", maxKi: "90 Septillion", race: "Saiyan", gender: "Male", description: "El protagonista de la serie, conocido por su gran poder y personalidad amigable. Originalmente enviado a la Tierra como un infante volador con la misión de conquistarla. Sin embargo, el caer por un barranco le proporcionó un brutal golpe que si bien casi lo mata, este alteró su memoria y anuló todos los instintos violentos de su especie, lo que lo hizo crecer con un corazón puro y bondadoso, pero conservando todos los poderes de su raza. No obstante, en la nueva continuidad de Dragon Ball se establece que él fue enviado por sus padres a la Tierra con el objetivo de sobrevivir a toda costa a la destrucción de su planeta por parte de Freeza. Más tarde, Kakarot, ahora conocido como Son Goku, se convertiría en el príncipe consorte del monte Fry-pan y líder de los Guerreros Z, así como el mayor defensor de la Tierra y del Universo 7, logrando mantenerlos a salvo de la destrucción en innumerables ocasiones, a pesar de no considerarse a sí mismo como un héroe o salvador.", image: "https://res.cloudinary.com/dgtgbyo76/image/upload/v1699044374/hlpy6q013uw3itl5jzic.webp", affiliation: "Z Fighter", deletedAt: nil), Character(id: 4, name: "Vegeta", ki: "54.000.000", maxKi: "19.84 Septillion", race: "Saiyan", gender: "Male", description: "Príncipe de los Saiyans, inicialmente un villano, pero luego se une a los Z Fighters. A pesar de que a inicios de Dragon Ball Z, Vegeta cumple un papel antagónico, poco después decide rebelarse ante el Imperio de Freeza, volviéndose un aliado clave para los Guerreros Z. Con el paso del tiempo llegaría a cambiar su manera de ser, optando por permanecer y vivir en la Tierra para luchar a su lado contra las inminentes adversidades que superar. Junto con Piccolo, él es de los antiguos enemigos de Goku que ha evolucionando al pasar de ser un villano y antihéroe, a finalmente un héroe a lo largo del transcurso de la historia, convirtiéndose así en el deuteragonista de la serie.", image: "https://res.cloudinary.com/dgtgbyo76/image/upload/v1699044422/i9hpfjplth6gjudvhsx3.webp", affiliation: "Z Fighter", deletedAt: nil)
        ], meta: Meta(totalItems: 58, itemCount: 58, itemsPerPage: 58, totalPages: 1, currentPage: 1), links: Links(first: "https://dragonball-api.com/api/characters?limit=58", previous: "", next: "", last: "https://dragonball-api.com/api/characters?limit=58"))
    }
    
    func getCharacters() async throws -> Characters {
        return testData
    }
    
    
}
