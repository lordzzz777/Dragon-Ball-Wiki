//
//  PlanetsViewModel.swift
//  DrgonBollWiki
//
//  Created by Jacob Aguilar on 03-03-24.
//

import Foundation

@Observable
class PlanetsViewModel {
    private let planetsDataSevice: PlanetsProtocol
    
    var allPlanets: Planets?
    var isLoading: Bool = false
    var showErrorMessage: Bool = false
    var errorMessage: String = ""
    
    init(planetsDataSevice: PlanetsProtocol) {
        self.planetsDataSevice = planetsDataSevice
    }
    
    ///Obtiene la información de los plantas y los guardda en la variable `allPlanets` de la clase `PlanetsViewModel`
    @MainActor
    func getAllPlanets() async {
        do {
            allPlanets = try await planetsDataSevice.getPlanets()
        } catch {
            print(error)
            errorMessage = "Error al intentar obtener datos de los planetas desde el servidor"
            showErrorMessage.toggle()
        }
    }
}
