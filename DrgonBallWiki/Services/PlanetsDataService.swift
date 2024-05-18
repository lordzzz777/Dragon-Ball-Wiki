//
//  PlanetsDataService.swift
//  DrgonBollWiki
//
//  Created by Jacob Aguilar on 03-03-24.
//

import Foundation

class PlanetsDataService: PlanetsProtocol {

    ///Obtiene tla información básica de todos los planetas
    /// - Returns: Una instancia de `Planets` la cual contiene toda la información básica de cada planeta
    func getPlanets() async throws -> Planets {
        do {
            let allPlanetsURL = "https://dragonball-api.com/api/planets?page=1&limit=58"
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
}
