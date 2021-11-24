//
//  CachePlanetsGatewayTest.swift
//  PlanetsTests
//
//  Created by Esraa Mohamed Ragab on 24/11/2021.
//

import XCTest
@testable import Planets

class CachePlanetsGatewayTest: XCTestCase {
    var apiPlanetsGatewaySpy = ApiPlanetsGatewaySpy()
    var localPersistencePlanetsGatewaySpy = LocalPersistencePlanetsGatewaySpy()
    
    var cachePlanetsGateway: CachePlanetsGateway!
    
    // MARK: - Set up
    
    override func setUp() {
        super.setUp()
        cachePlanetsGateway = CachePlanetsGateway(apiPlanetsGateway: apiPlanetsGatewaySpy,
                                                localPersistencePlanetsGateway: localPersistencePlanetsGatewaySpy)
    }
    
    // MARK: - Tests
    
    func test_fetchPlanets_api_success_save_locally() {
        // Given
        let planetsToReturn = Planet.createPlanetsArray()
        let expectedResultToBeReturned: Result<[Planet]> = .success(planetsToReturn)
        
        apiPlanetsGatewaySpy.fetchPlanetsResultToBeReturned = expectedResultToBeReturned
        
        let fetchPlanetsCompletionHandlerExpectation = expectation(description: "Fetch planets completion handler expectation")
        
        // When
        cachePlanetsGateway.fetchPlanets { (result) in
            // Then
            XCTAssertTrue(expectedResultToBeReturned == result, "The expected result wasn't returned")
            XCTAssertEqual(planetsToReturn, self.localPersistencePlanetsGatewaySpy.planetsSaved, "The planets weren't saved on the local persistence")
            
            fetchPlanetsCompletionHandlerExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func test_fetchPlanets_api_failure_fetch_from_local_persistence() {
        // Given
        let planetsToReturnFromLocalPersistence = Planet.createPlanetsArray()
        let expectedResultToBeReturnedFromLocalPersistence: Result<[Planet]> = .success(planetsToReturnFromLocalPersistence)
        let expectedResultFromApi: Result<[Planet]> = .failure(NSError.createError(withMessage: "Some error fetching planets"))
        
        apiPlanetsGatewaySpy.fetchPlanetsResultToBeReturned = expectedResultFromApi
        localPersistencePlanetsGatewaySpy.fetchPlanetsResultToBeReturned = expectedResultToBeReturnedFromLocalPersistence
        
        let fetchPlanetsCompletionHandlerExpectation = expectation(description: "Fetch planets completion handler expectation")
        
        // When
        cachePlanetsGateway.fetchPlanets { (result) in
            // Then
            XCTAssertTrue(expectedResultToBeReturnedFromLocalPersistence == result, "The expected result wasn't returned")
            XCTAssertTrue(self.localPersistencePlanetsGatewaySpy.fetchPlanetsCalled, "Fetch planets wasn't called on the local persistence")
            
            fetchPlanetsCompletionHandlerExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
    }
    
}
