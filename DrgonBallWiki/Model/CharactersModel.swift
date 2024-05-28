//
//  CharactersModel.swift
//  DrgonBollWiki
//
//  Created by Grupo de Estudio on 1/3/24.
//

import SwiftUI

enum Race: String, Codable {
    case evil = "Evil"
    case android = "Android"
    case majin = "Majin"
    case nucleico = "Nucleico"
    case namekian = "Namekian"
    case saiyan = "Saiyan"
    case jirenRace = "Jiren Race"
    case friezaRace = "Frieza Race"
    case nucleicoBenigno = "Nucleico benigno"
    case human = "Human"
    case angel = "Angel"
    case god = "God"
    case unknown = "Unknown"

    var color: Color {
        switch self {
        case .evil: return .black
        case .android: return .cyan
        case .majin: return .pink
        case .nucleico: return .white
        case .namekian: return .green
        case .saiyan: return .yellow
        case .jirenRace: return .red
        case .friezaRace: return .gray
        case .nucleicoBenigno: return .brown
        case .human: return .blue
        case .angel: return .mint
        case .god: return .indigo
        case .unknown: return .white
        }
    }
}

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

    var characterKiColor: Color {
        Race(rawValue: race)?.color ?? .white
    }
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


// MARK: - View Card
extension Array where Element == Character {
    func zIndex(_ item: Character) -> CGFloat {
        if let index = firstIndex(where: { $0.id == item.id }) {
            return CGFloat(count) - CGFloat(index)
        }
        return .zero
    }
}
