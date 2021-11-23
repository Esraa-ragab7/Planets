//
//  PlanetsPresenter.swift
//  Planets
//
//  Created by Esraa Mohamed Ragab on 23/11/2021.
//

import Foundation

protocol PlanetsView: AnyObject {
    func refreshPlanetsView()
    func displayPlanetsRetrievalError(title: String, message: String)
}

protocol PlanetCellView {
    func display(title: String)
}

protocol PlanetsPresenter {
    var numberOfPlanets: Int { get }
    func viewDidLoad()
    func configure(cell: PlanetCellView, forRow row: Int)
}

class PlanetsPresenterImplementation: PlanetsPresenter {
    var numberOfPlanets: Int = 0
    
    func viewDidLoad() {
        
    }
    
    func configure(cell: PlanetCellView, forRow row: Int) {
        
    }
}
