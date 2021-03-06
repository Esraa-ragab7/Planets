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
    fileprivate weak var view: PlanetsView?
    fileprivate let displayPlanetsUseCase: DisplayPlanetsUseCase
    
    // we keep this internal so we can inject values for testing purposes
    var planets = [Planet]()
    
    var numberOfPlanets: Int {
        return planets.count
    }
    
    // init the Planets Presenter Implementation data
    init(view: PlanetsView,
         displayPlanetsUseCase: DisplayPlanetsUseCase) {
        self.view = view
        self.displayPlanetsUseCase = displayPlanetsUseCase
    }
    
    func viewDidLoad() {
        // Fetching the planets data
        self.displayPlanetsUseCase.displayPlanets { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case let .success(planets):
                self.handlePlanetsReceived(planets)
            case let .failure(error):
                self.handlePlanetsError(error)
            }
        }
    }
    
    func configure(cell: PlanetCellView, forRow row: Int) {
        // configure the planet cell and display the title
        let planet = planets[row]
        
        cell.display(title: planet.name)
    }
    
    // MARK: - Private Functions
    
    fileprivate func handlePlanetsReceived(_ planets: [Planet]) {
        // set planets data and refresh the view
        self.planets = planets
        view?.refreshPlanetsView()
    }
    
    fileprivate func handlePlanetsError(_ error: Error) {
        view?.displayPlanetsRetrievalError(title: "Error", message: error.localizedDescription)
    }
}
