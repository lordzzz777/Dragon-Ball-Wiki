//
//  CharactersModel.swift
//  DrgonBollWiki
//
//  Created by Jacob Aguilar on 01-03-24.
//

import Foundation

// MARK: - Character
struct Characters: Codable {
    let items: [Item]
    let meta: Meta
    let links: Links
}

// MARK: - Item
struct Item: Codable {
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
