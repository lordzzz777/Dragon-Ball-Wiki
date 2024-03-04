//
//  APIService.swift
//  DrgonBollWiki
//
//  Created by Jacob Aguilar on 01-03-24.
//

import Foundation
//import Observation


@Observable
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
    
    
    ///Obtiene los datos de un solo personaje basandose en el id
    /// - Parameters: id del personaje
    /// - Returns: Una instancia de `SingleCharacter` la cual contiene toda la información de un personaje en específico
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
    
    ///Obtiene tla información básica de todos los planetas
    /// - Returns: Una instancia de `Planets` la cual contiene toda la información básica de cada planeta
    func getPlanets() async throws -> Planets {
        do {
            let allPlanetsURL = "https://dragonball-api.com/api/planets?page=1&limit=30"
            guard let url = URL(string: allPlanetsURL) else {
                throw ApiError.invalidURL
            }
            
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                throw ApiError.invalidResponse
            }
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return try decoder.decode(Planets.self, from: data)
        } catch {
            throw error
        }
    }
    
    ///Obtiene los datos completos de un planeta en particular basándose en su id
    /// - Parameters: id de tipo `Int`
    /// - Returns: Una instancia de `SinglePlanet` la cual contiene toda la información de un planeta en específico
    func getSinglePlanet(id: Int) async throws -> SinglePlanet {
        do {
            let planetURL = "https://dragonball-api.com/api/planets/\(id)"
            guard let url = URL(string: planetURL) else {
                throw ApiError.invalidURL
            }
            
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                throw ApiError.invalidResponse
            }
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return try decoder.decode(SinglePlanet.self, from: data)
        } catch {
            throw error
        }
    }
}


