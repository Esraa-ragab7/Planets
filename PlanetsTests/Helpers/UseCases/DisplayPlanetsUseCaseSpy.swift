//
//  DisplayPlanetsListSpy.swift
//  PlanetsTests
//
//  Created by Esraa Mohamed Ragab on 24/11/2021.
//

import Foundation
@testable import Library

class DisplayPlanetsListSpy: Displa {
    var resultToBeReturned: Result<[Book]>!
    
    func displayBooks(completionHandler: @escaping (Result<[Book]>) -> Void) {
        completionHandler(resultToBeReturned)
    }
}
