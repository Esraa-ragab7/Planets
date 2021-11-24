//
//  PlanetCellViewSpy.swift
//  PlanetsTests
//
//  Created by Esraa Mohamed Ragab on 24/11/2021.
//

import Foundation
@testable import Planets

class PlanetCellViewSpy: PlanetCellView {
    var displayedName = ""
    
    func display(title: String) {
        displayedName = title
    }
}
