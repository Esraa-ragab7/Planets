//
//  LocalPersistencePlanetsGateway.swift
//  Planets
//
//  Created by Esraa Mohamed Ragab on 24/11/2021.
//

import Foundation
import CoreData

protocol LocalPersistencePlanetsGateway: PlanetsGateway {
    func save(planets: [Planet])
}

class CoreDataPlanetsGateway: LocalPersistencePlanetsGateway {
    
    let viewContext: NSManagedObjectContextProtocol
    
    init(viewContext: NSManagedObjectContextProtocol) {
        self.viewContext = viewContext
    }
    
    // MARK: - PlanetsGateway
    
    func fetchPlanets(completionHandler: @escaping FetchPlanetsEntityGatewayCompletionHandler) {
        if let coreDataPlanets = try? viewContext.allEntities(withType: CoreDataPlanet.self) {
            let planets = coreDataPlanets.map { $0.planet }
            completionHandler(.success(planets))
        } else {
            completionHandler(.failure(CoreError(message: "Failed retrieving planets the data base")))
        }
    }
    
    // MARK: - LocalPersistencePlanetsGateway
    
    func save(planets: [Planet]) {
        for planet in planets {
            guard let coreDataPlanet = viewContext.addEntity(withType: CoreDataPlanet.self) else {
                return
            }
            
            let predicate = NSPredicate(format: "name==%@", planet.name)

            if let coreDataPlanets = try? viewContext.allEntities(withType: CoreDataPlanet.self, predicate: predicate), let coreDataPlanet = coreDataPlanets.first {
                coreDataPlanet.populate(with: planet)
            } else {
                coreDataPlanet.populate(with: planet)
            }
            
            do {
                try viewContext.save()
            } catch {
                viewContext.delete(coreDataPlanet)
            }
        }
    }
}
