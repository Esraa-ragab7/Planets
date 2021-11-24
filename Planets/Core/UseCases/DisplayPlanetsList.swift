//
//  DisplayPlanetsList.swift
//  Planets
//
//  Created by Esraa Mohamed Ragab on 23/11/2021.
//

import Foundation

typealias DisplayPlanetsUseCaseCompletionHandler = (_ planets: Result<[Planet]>) -> Void

protocol DisplayPlanetsUseCase {
    func displayPlanets(completionHandler: @escaping DisplayPlanetsUseCaseCompletionHandler)
}

class DisplayPlanetsUseCaseImplementation: DisplayPlanetsUseCase {
    let planetsGateway: PlanetsGateway
    
    init(planetsGateway: PlanetsGateway) {
        self.planetsGateway = planetsGateway
    }
    
    // MARK: - DisplayPlanetsUseCase
    
    func displayPlanets(completionHandler: @escaping (Result<[Planet]>) -> Void) {
        self.planetsGateway.fetchPlanets { (result) in
            // Do any additional processing & after that call the completion handler
            completionHandler(result)
        }
    }
}
