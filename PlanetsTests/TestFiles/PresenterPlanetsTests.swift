//
//  PlanetsTests.swift
//  PlanetsTests
//
//  Created by Esraa Mohamed Ragab on 22/11/2021.
//

import XCTest
@testable import Planets

class PresenterPlanetsTests: XCTestCase {
    let displayPlanetsUseCaseSpy = DisplayPlanetsUseCaseSpy()
    let planetsViewSpy = PlanetsViewSpy()
    
    var planetsPresenter: PlanetsPresenterImplementation!
    
    // MARK: - Set up
    
    override func setUp() {
        super.setUp()
        planetsPresenter = PlanetsPresenterImplementation(view: planetsViewSpy,
                                                          displayPlanetsUseCase: displayPlanetsUseCaseSpy)
    }
    
    // MARK: - Tests
    
    func test_viewDidLoad_success_refreshPlanetsView_called() {
        // Given
        let planetsToBeReturned = Planet.createPlanetsArray()
        displayPlanetsUseCaseSpy.resultToBeReturned = .success(planetsToBeReturned)
        
        // When
        planetsPresenter.viewDidLoad()
        
        // Then
        XCTAssertTrue(planetsViewSpy.refreshPlanetsViewCalled, "refreshPlanetsView was not called")
    }
    
    func test_viewDidLoad_failure_displayPlanetsRetrievalError() {
        // Given
        let expectedErrorTitle = "Error"
        let expectedErrorMessage = "Some error message"
        let errorToBeReturned = NSError.createError(withMessage: expectedErrorMessage)
        displayPlanetsUseCaseSpy.resultToBeReturned = .failure(errorToBeReturned)
        
        // When
        planetsPresenter.viewDidLoad()
        
        // Then
        XCTAssertEqual(expectedErrorTitle, planetsViewSpy.displayPlanetsRetrievalErrorTitle, "Error title doesn't match")
        XCTAssertEqual(expectedErrorMessage, planetsViewSpy.displayPlanetsRetrievalErrorMessage, "Error message doesn't match")
    }
    
    func test_viewDidLoad_success_numberOfPlanets() {
        // Given
        let expectedNumberOfPlanets = 10
        let planetsToBeReturned = Planet.createPlanetsArray(numberOfElements: expectedNumberOfPlanets)
        displayPlanetsUseCaseSpy.resultToBeReturned = .success(planetsToBeReturned)
        
        // When
        planetsPresenter.viewDidLoad()
        
        // Then
        XCTAssertEqual(expectedNumberOfPlanets, planetsPresenter.numberOfPlanets, "Number of planets mismatch")
    }
    
    func test_configureCell() {
        // Given
        planetsPresenter.planets = Planet.createPlanetsArray()
        let expectedDisplayedName = "Planet 1"
        
        let planetCellViewSpy = PlanetCellViewSpy()
        
        // When
        planetsPresenter.configure(cell: planetCellViewSpy, forRow: 1)
        
        // Then
        XCTAssertEqual(expectedDisplayedName, planetCellViewSpy.displayedName, "The name we expected was not displayed")
    }
}
