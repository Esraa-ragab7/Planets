//
//  PlanetsConfigurator.swift
//  Planets
//
//  Created by Esraa Mohamed Ragab on 24/11/2021.
//

import Foundation

protocol PlanetsConfigurator {
    func configure(plantesTableViewController: PlantesTableViewController)
}

class PlanetsConfiguratorImplementation: PlanetsConfigurator {
    
    func configure(plantesTableViewController: PlantesTableViewController) {
        let apiClient = ApiClientImplementation(urlSessionConfiguration: URLSessionConfiguration.default,
                                                completionHandlerQueue: OperationQueue.main)
        let apiPlanetsGateway = ApiPlanetsGatewayImplementation(apiClient: apiClient)
        
        let viewContext = CoreDataStackImplementation.sharedInstance.persistentContainer.viewContext
        let coreDataPlanetsGateway = CoreDataPlanetsGateway(viewContext: viewContext)
        let planetsGateway = CachePlanetsGateway(apiPlanetsGateway: apiPlanetsGateway,
                                             localPersistencePlanetsGateway: coreDataPlanetsGateway)
        
        let displayPlanetsUseCase = DisplayPlanetsUseCaseImplementation(planetsGateway: planetsGateway)

        // We should add router implementation here in case we handle directions and inject it inside the presenter

        let presenter = PlanetsPresenterImplementation(view: plantesTableViewController,
                                                       displayPlanetsUseCase: displayPlanetsUseCase)
        
        plantesTableViewController.presenter = presenter
    }
}
