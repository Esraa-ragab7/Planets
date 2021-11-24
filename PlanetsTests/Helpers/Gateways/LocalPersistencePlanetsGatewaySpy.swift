//
//  LocalPersistencePlanetsGatewaySpy.swift
//  PlanetsTests
//
//  Created by Esraa Mohamed Ragab on 24/11/2021.
//

import Foundation
@testable import Planets

class LocalPersistencePlanetsGatewaySpy: LocalPersistencePlanetsGateway {
    var fetchPlanetsResultToBeReturned: Result<[Planet]>!
    var planetsSaved: [Planet]!
    var fetchPlanetsCalled = false
    
    
    func fetchPlanets(completionHandler: @escaping FetchPlanetsEntityGatewayCompletionHandler) {
        fetchPlanetsCalled = true
        completionHandler(fetchPlanetsResultToBeReturned)
    }

    func save(planets: [Planet]) {
        planetsSaved = planets
    }

}
