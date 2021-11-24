//
//  CachePlanetsGateway.swift
//  Planets
//
//  Created by Esraa Mohamed Ragab on 24/11/2021.
//

import Foundation

class CachePlanetsGateway: PlanetsGateway {
    let apiPlanetsGateway: ApiPlanetsGateway
    let localPersistencePlanetsGateway: LocalPersistencePlanetsGateway
    
    init(apiPlanetsGateway: ApiPlanetsGateway, localPersistencePlanetsGateway: LocalPersistencePlanetsGateway) {
        self.apiPlanetsGateway = apiPlanetsGateway
        self.localPersistencePlanetsGateway = localPersistencePlanetsGateway
    }
    
    // MARK: - Planets Gateway
    
    func fetchPlanets(completionHandler: @escaping FetchPlanetsEntityGatewayCompletionHandler) {
        apiPlanetsGateway.fetchPlanets { (result) in
            self.handleFetchPlanetsApiResult(result, completionHandler: completionHandler)
        }
    }
    
    // MARK: - Private functions
    
    fileprivate func handleFetchPlanetsApiResult(_ result: Result<[Planet]>, completionHandler: @escaping FetchPlanetsEntityGatewayCompletionHandler) {
        switch result {
        case let .success(planets):
            localPersistencePlanetsGateway.save(planets: planets)
            completionHandler(result)
        case .failure(_):
            localPersistencePlanetsGateway.fetchPlanets(completionHandler: completionHandler)
        }
    }
    
}
