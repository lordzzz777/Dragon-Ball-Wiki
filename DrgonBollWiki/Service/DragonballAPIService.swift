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
    
    ///Obtiene un personaje correspondiente al id
    /// - Parameters: un id de tipo `Int`
    /// - Returns: Una instancia de `SingleCharacter` la cual tiene toda la información de un personaje
    func getSingleCharcter(id: Int) async throws -> SingleCharacter {
        do {
            let singleCharacterURL = "https://dragonball-api.com/api/characters/\(id)"
            guard let url = URL(string: singleCharacterURL) else {
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
