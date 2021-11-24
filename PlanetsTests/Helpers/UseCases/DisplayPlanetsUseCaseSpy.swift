//
//  DisplayPlanetsUseCaseSpy.swift
//  PlanetsTests
//
//  Created by Esraa Mohamed Ragab on 24/11/2021.
//

import Foundation
@testable import Planets

class DisplayPlanetsUseCaseSpy: DisplayPlanetsUseCase {
    var resultToBeReturned: Result<[Planet]>!
    
    func displayPlanets(completionHandler: @escaping DisplayPlanetsUseCaseCompletionHandler) {
        completionHandler(resultToBeReturned)
    }
    
}
