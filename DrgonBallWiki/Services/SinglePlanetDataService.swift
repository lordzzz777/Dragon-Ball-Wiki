//
//  SinglePlanetDataService.swift
//  DrgonBollWiki
//
//  Created by Jacob Aguilar on 03-03-24.
//

import Foundation

class SinglePlanetDataService: SinglePlanetProtocol {
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
