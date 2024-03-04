//
//  SinglePlanetViewModel.swift
//  DrgonBollWiki
//
//  Created by Jacob Aguilar on 03-03-24.
//

import Foundation

@Observable
class SinglePlanetViewModel {
    private let singlePlanetDataService: SinglePlanetProtocol
    
    var planet: SinglePlanet?
    var isLoading: Bool = false
    var showErrorMessage: Bool = false
    var errorMessage: String = ""
    
    init(singlePlanetDataService: SinglePlanetProtocol) {
        self.singlePlanetDataService = singlePlanetDataService
    }
    
    @MainActor
    func getPlanetInformation(planetID id: Int) async {
        do {
            planet = try await singlePlanetDataService.getSinglePlanet(id: id)
            if let planet = planet {
                print("Se pbtuvo la información del planeta \(planet) correctamente")
            }
        } catch {
            print(error)
            errorMessage = "Error al intentar obtener los datos del planeta desde el servidor"
            showErrorMessage.toggle()
        }
    }
}
