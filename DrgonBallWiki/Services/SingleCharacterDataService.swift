//
//  SingleCharacterDataService.swift
//  DrgonBollWiki
//
//  Created by Jacob Aguilar on 03-03-24.
//

import Foundation

class SingleCharacterDataService: SingleCharacterProtocol {
    
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
}
