//
//  ApiPlanetsGatewaySpy.swift
//  PlanetsTests
//
//  Created by Esraa Mohamed Ragab on 24/11/2021.
//

import Foundation
@testable import Planets

class ApiPlanetsGatewaySpy: ApiPlanetsGateway {
    var fetchPlanetsResultToBeReturned: Result<[Planet]>!

    func fetchPlanets(completionHandler: @escaping FetchPlanetsEntityGatewayCompletionHandler) {
        completionHandler(fetchPlanetsResultToBeReturned)
    }
    
}
