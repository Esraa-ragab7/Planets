//
//  PlanetsViewSpy.swift
//  PlanetsTests
//
//  Created by Esraa Mohamed Ragab on 24/11/2021.
//

import Foundation
@testable import Planets

class PlanetsViewSpy: PlanetsView {
    var refreshPlanetsViewCalled = false
    var displayPlanetsRetrievalErrorTitle: String?
    var displayPlanetsRetrievalErrorMessage: String?
    
    func refreshPlanetsView() {
        refreshPlanetsViewCalled = true
    }
    
    func displayPlanetsRetrievalError(title: String, message: String) {
        displayPlanetsRetrievalErrorTitle = title
        displayPlanetsRetrievalErrorMessage = message
    }
}
