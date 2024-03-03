//
//  CharactersModel.swift
//  DrgonBollWiki
//
//  Created by Grupo de Estudio on 1/3/24.
//

import Foundation

// MARK: - Character
struct Characters: Codable {
    let items: [Character]
    let meta: Meta
    let links: Links
}

// MARK: - Item
struct Character: Codable {
    let id: Int
    let name, ki, maxKi, race: String
    let gender, description: String
    let image: String
    let affiliation: String
    let deletedAt: Date?
}

// MARK: - Links
struct Links: Codable {
    let first: String
    let previous: String
    let next, last: String
}

// MARK: - Meta
struct Meta: Codable {
    let totalItems, itemCount, itemsPerPage, totalPages: Int
    let currentPage: Int
}
