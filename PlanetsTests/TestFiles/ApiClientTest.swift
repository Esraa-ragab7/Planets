//
//  ApiClientTest.swift
//  PlanetsTests
//
//  Created by Esraa Mohamed Ragab on 24/11/2021.
//

import XCTest
@testable import Planets

class ApiClientTest: XCTestCase {
    let urlSessionSpy = UrlSessionSpy()
    
    var apiClient: ApiClientImplementation!
    
    
    // MARK: - Set up
    
    override func setUp() {
        super.setUp()
        apiClient = ApiClientImplementation(urlSession: urlSessionSpy)
    }
    
    // MARK: - Tests

    func test_execute_successful_http_response_parses_ok() {
        // Given
        
        // Normally to mock JSON responses you should use a Dictionary and convert it to JSON using JSONSerialization.data In our example here we don't care about the actual JSON, we care about the data regardless of its format it would have
        let expectedUtf8StringResponse = "{\"SomeProperty\":\"SomeValue\"}"
        let expectedData = expectedUtf8StringResponse.data(using: .utf8)
        let expected2xxReponse = HTTPURLResponse(statusCode: 200)
        
        urlSessionSpy.enqueue(response: (data: expectedData, response: expected2xxReponse, error: nil))
        
        let executeCompletionHandlerExpectation = expectation(description: "get planets completion handler expectation")
        
        // When
        apiClient.execute(request: TestDoubleRequest()) { (result: Result<ApiResponse<TestDoubleApiEntity>>) in
            // Then
            guard let response = try? result.get() else {
                XCTFail("A successfull response should've been returned")
                return
            }
            XCTAssertEqual(expectedUtf8StringResponse, response.entity.utf8String, "The string is not the expected one")
            XCTAssertTrue(expected2xxReponse === response.httpUrlResponse, "The http response is not the expected one")
            XCTAssertEqual(expectedData?.base64EncodedString(), response.data?.base64EncodedString(), "Data doesn't match")
            
            executeCompletionHandlerExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func test_execute_successful_http_response_prase_error() {
        // Given
        let expectedUtf8StringResponse = "{ \"SomeProperty\" : \"SomeValue\" }"
        let expectedData = expectedUtf8StringResponse.data(using: .utf8)
        let expected2xxReponse = HTTPURLResponse(statusCode: 200)
        let expectedParsingErrorMessage = "A parsing error occured"
        
        urlSessionSpy.enqueue(response: (data: expectedData, response: expected2xxReponse, error: nil))
        
        let executeCompletionHandlerExpectation = expectation(description: "get planets completion handler expectation")
        
        // When
        apiClient.execute(request: TestDoubleRequest()) { (result: Result<ApiResponse<TestDoubleErrorParseApiEntity>>) in
            // Then
            do {
                let _ = try result.get()
                XCTFail("Expected parse error to be thrown")
            } catch let error as ApiParseError {
                XCTAssertTrue(expected2xxReponse === error.httpUrlResponse, "The http response is not the expected one")
                XCTAssertEqual(expectedData?.base64EncodedString(), error.data?.base64EncodedString(), "Data doesn't match")
                XCTAssertEqual(expectedParsingErrorMessage, error.localizedDescription, "Error message doesn't match")
            } catch {
                XCTFail("Expected parse error to be thrown")
            }
            
            executeCompletionHandlerExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func test_execute_non_2xx_response_code() {
        let expectedUtf8StringResponse = "{ \"SomeProperty\" : \"SomeValue\" }"
        let expectedData = expectedUtf8StringResponse.data(using: .utf8)
        let expected4xxReponse = HTTPURLResponse(statusCode: 400)
        
        urlSessionSpy.enqueue(response: (data: expectedData, response: expected4xxReponse, error: nil))
        
        let executeCompletionHandlerExpectation = expectation(description: "get planet completion handler expectation")
        
        // When
        apiClient.execute(request: TestDoubleRequest()) { (result: Result<ApiResponse<TestDoubleApiEntity>>) in
            // Then
            do {
                let _ = try result.get()
                XCTFail("Expected api error to be thrown")
            } catch let error as ApiError {
                XCTAssertTrue(expected4xxReponse === error.httpUrlResponse, "The http response is not the expected one")
                XCTAssertEqual(expectedData?.base64EncodedString(), error.data?.base64EncodedString(), "Data doesn't match")
            } catch {
                XCTFail("Expected api error to be thrown")
            }
            
            executeCompletionHandlerExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func test_execute_error_no_httpurlresponse() {
        // Given
        let expectedErrorMessage = "Some random network error"
        let expectedError = NSError.createError(withMessage: expectedErrorMessage)
        
        urlSessionSpy.enqueue(response: (data: nil, response: nil, error: expectedError))
        
        let executeCompletionHandlerExpectation = expectation(description: "get Planet completion handler expectation")
        
        // When
        apiClient.execute(request: TestDoubleRequest()) { (result: Result<ApiResponse<TestDoubleApiEntity>>) in
            // Then
            do {
                let _ = try result.get()
                XCTFail("Expected network error to be thrown")
            } catch let error as NetworkRequestError {
                XCTAssertEqual(expectedErrorMessage, error.localizedDescription, "Error message doesn't match")
            } catch {
                XCTFail("Expected network error to be thrown")
            }
            
            executeCompletionHandlerExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
    }
}


private struct TestDoubleRequest: ApiRequest {
    var urlRequest: URLRequest {
        return URLRequest(url: URL.googleUrl)
    }
}

private struct TestDoubleApiEntity: Codable {
    var SomeProperty: String
    
    var utf8String: String {
        let data = try? JSONEncoder().encode(self)
        return String(data: data!, encoding: .utf8)!
    }
}

private struct TestDoubleErrorParseApiEntity: Decodable {
    init(from decoder: Decoder) throws {
        throw NSError.createPraseError()
    }
}


