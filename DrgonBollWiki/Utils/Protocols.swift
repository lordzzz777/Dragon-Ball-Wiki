//
//  Protocols.swift
//  DrgonBollWiki
//
//  Created by Jacob Aguilar on 03-03-24.
//

import Foundation

protocol AllCharactersProtocol {
    func getCharacters() async throws -> Characters
}

protocol SingleCharacterProtocol {
    func getSingleCharacter(id: Int) async throws -> SingleCharacter
}

protocol PlanetsProtocol {
    func getPlanets() async throws -> Planets
}
