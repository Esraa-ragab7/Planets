//
//  CoreDataPlanetsGatewayTest.swift
//  PlanetsTests
//
//  Created by Esraa Mohamed Ragab on 24/11/2021.
//

import XCTest
@testable import Planets

class CoreDataPlanetsGatewayTest: XCTestCase {
    var inMemoryCoreDataStack = InMemoryCoreDataStack()
    var managedObjectContextSpy = NSManagedObjectContextSpy()
    
    var inMemoryCoreDataPlanetsGateway: CoreDataPlanetsGateway {
        return CoreDataPlanetsGateway(viewContext: inMemoryCoreDataStack.persistentContainer.viewContext)
    }
    
    var errorPathCoreDataPlanetsGateway: CoreDataPlanetsGateway {
        return CoreDataPlanetsGateway(viewContext: managedObjectContextSpy)
    }
    
    // MARK: - Tests
    
    func test_fetch_success() {
        // Given
        let planetsToReturn = Planet.createPlanetsArray()
        let fetchBooksCompletionHandlerExpectation = expectation(description: "Fetch planets completion handler expectation")
       
        inMemoryCoreDataPlanetsGateway.save(planets: planetsToReturn)
    
        // When
        inMemoryCoreDataPlanetsGateway.fetchPlanets { (result) in
            // Then
            guard var planets = try? result.get() else {
                XCTFail("Should've returned the planets with success")
                return
            }
            planets.sort(by: {$0.name < $1.name})
            XCTAssertTrue(planetsToReturn == planets, "Failure error wasn't returned")
            
            fetchBooksCompletionHandlerExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func test_fetch_failure() {
        // Given
        let expectedResultToBeReturned: Result<[Planet]> = .failure(CoreError(message: "Failed retrieving planets the data base"))
        managedObjectContextSpy.fetchErrorToThrow = NSError.createError(withMessage: "Some core data error")
        let fetchPlanetsCompletionHandlerExpectation = expectation(description: "Fetch planets completion handler expectation")
        
        // When
        errorPathCoreDataPlanetsGateway.fetchPlanets { (result) in
            // Then
            XCTAssertTrue(expectedResultToBeReturned == result, "Failure error wasn't returned")
            fetchPlanetsCompletionHandlerExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
    }
}
