//
//  PlanetsGateway.swift
//  Planets
//
//  Created by Esraa Mohamed Ragab on 23/11/2021.
//

import Foundation

typealias FetchPlanetsEntityGatewayCompletionHandler = (_ planets: Result<[Planet]>) -> Void

protocol PlanetsGateway {
    func fetchPlanets(completionHandler: @escaping FetchPlanetsEntityGatewayCompletionHandler)
}
