//
//  PlanetsGatewaySpy.swift
//  PlanetsTests
//
//  Created by Esraa Mohamed Ragab on 24/11/2021.
//

import Foundation
@testable import Planets

class PlanetsGatewaySpy: PlanetsGateway {
    
    var fetchPlanetsResultToBeReturned: Result<[Planet]>!
    
    func fetchPlanets(completionHandler: @escaping FetchPlanetsEntityGatewayCompletionHandler) {
        
    }
}
