//
//  APIService.swift
//  DrgonBollWiki
//
//  Created by Jacob Aguilar on 01-03-24.
//

import Foundation

final class DragonballAPIService {
    private let allCharactersEndPoint = "https://dragonball-api.com/api/characters?page=1&limit=58"
    
    private enum ApiError: Error {
        case invalidURL
        case invalidResponse
    }

    
    ///Obtiene todos los personajes de Dragonball API
    /// - Returns: Una instancia de `Characters` la cual contiene toda la información básica de cada personaje
    func getCharacters() async throws -> Characters {
        do {
            guard let url = URL(string: allCharactersEndPoint) else {
                throw ApiError.invalidURL
            }
            
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                throw ApiError.invalidResponse
            }
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return try decoder.decode(Characters.self, from: data)
        } catch {
            throw error
        }
    }
    
    
    func getSingleCharacter(id: Int) async throws -> SingleCharacter {
        do {
            let singleCharacterEndPoint = "https://dragonball-api.com/api/characters/\(id)"
            guard let url = URL(string: singleCharacterEndPoint) else {
                throw ApiError.invalidURL
            }
            
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                throw ApiError.invalidResponse
            }
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return try decoder.decode(SingleCharacter.self, from: data)
        } catch {
            throw error
        }
    }
}


