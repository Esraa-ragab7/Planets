//
//  ApiPlanetsGateway.swift
//  Planets
//
//  Created by Esraa Mohamed Ragab on 23/11/2021.
//

import Foundation

// This protocol in not necessarily needed since it doesn't include any extra methods besides what PlanetsGateway already provides if there would be any extra methods
protocol ApiPlanetsGateway: PlanetsGateway {
    
}

class ApiPlanetsGatewayImplementation: ApiPlanetsGateway {
    let apiClient: ApiClient
    
    init(apiClient: ApiClient) {
        self.apiClient = apiClient
    }
    
    // MARK: - ApiPlanetsGateway
    
    func fetchPlanets(completionHandler: @escaping (Result<[Planet]>) -> Void) {
        let planetsApiRequest = PlanetsApiRequest()
        apiClient.execute(request: planetsApiRequest) { (result: Result<ApiResponse<ApiPlanetsResponse>>) in
            switch result {
            case let .success(response):
                let planetsResponse = response.entity.planets
                completionHandler(.success(planetsResponse))
            case let .failure(error):
                completionHandler(.failure(error))
            }
        }
    }
    
}
