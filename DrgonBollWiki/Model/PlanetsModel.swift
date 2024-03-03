//
//  PlanetsModel.swift
//  DrgonBollWiki
//
//  Created by Jacob Aguilar on 02-03-24.
//

import Foundation

// MARK: - Planets
struct Planets: Codable {
    let items: [Planet]
    let meta: Meta
    let links: Links
}

// MARK: - Item
struct Planet: Codable {
    let id: Int
    let name: String
    let isDestroyed: Bool
    let description: String
    let image: String
    let deletedAt: Date?
}

