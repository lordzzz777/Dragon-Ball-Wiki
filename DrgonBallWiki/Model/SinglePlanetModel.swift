//
//  SinglePlanetModel.swift
//  DrgonBollWiki
//
//  Created by Jacob Aguilar on 02-03-24.
//

import Foundation

struct SinglePlanet: Codable {
    let id: Int
    let name: String
    let isDestroyed: Bool
    let description: String
    let image: String
    let deletedAt: Date?
    let characters: [Character]
}
