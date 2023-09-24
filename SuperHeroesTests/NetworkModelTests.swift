//
//  NetworkModelTests.swift
//  SuperHeroesTests
//
//  Created by Pablo Márquez Marín on 19/9/23.
//

import XCTest
@testable import SuperHeroes

final class NetworkModelTests: XCTestCase {
    private var sut: NetworkModel!
    
    override func setUp() {
        super.setUp()
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURLProtocol.self]
        let session = URLSession(configuration: configuration)
        sut = NetworkModel(session: session)
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
    }
    // GIVEN WHEN THEN
    func testGivenOkCredentialsWhenLoginThenSuccess() throws {
        let someUser = "SomeUser"
        let somePassword = "SomePassword"
        let expectedToken = "SomeToken"
        
        createRequest(credentials: .init(user: someUser,
                                         password: somePassword),
                      expectedToken: expectedToken)
       
        let expectation = expectation(description: "Login success")
        var output: String?
        sut.login(
            user: someUser,
            password: somePassword
        ) { result in
            guard case let .success(token) = result else {
                XCTFail("Expected success but received \(result)")
                return
            }
            output = token
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1)
        let outputResult: String = try XCTUnwrap(output)
        XCTAssertEqual(outputResult, expectedToken)
    }
}

private extension NetworkModelTests {
    
    struct Credentials {
        let user: String
        let password: String
    }
    
    func createRequest(
        credentials: Credentials,
        expectedToken: String
    ) {
        MockURLProtocol.requestHandler = { request in
            let loginString = String(format: "%@:%@", 
                                     credentials.user,
                                     credentials.password)
            let loginData = loginString.data(using: .utf8)!
            let base64LogingString = loginData.base64EncodedString()
            
            XCTAssertEqual(request.httpMethod, 
                           "POST")
            XCTAssertEqual(
                request.value(forHTTPHeaderField: "Authorization"),
                "Basic \(base64LogingString)"
            )
            
            let data = try XCTUnwrap(expectedToken.data(using: .utf8))
            let response = try XCTUnwrap(
                HTTPURLResponse(
                    url: URL(string: "https://dragonball.keepcoding.education")!,
                    statusCode: 200,
                    httpVersion: nil,
                    headerFields: ["Content-Type": "application/json"]
                )
            )
            return (response, data)
        }
    }
}

// OHHTTPStubs
final class MockURLProtocol: URLProtocol {
    static var error: NetworkModel.NetworkError?
    static var requestHandler: ((URLRequest) throws -> (HTTPURLResponse, Data))?
    
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    override func startLoading() {
        if let error = MockURLProtocol.error {
            client?.urlProtocol(self, didFailWithError: error)
            return
        }
        
        guard let handler = MockURLProtocol.requestHandler else {
            assertionFailure("Received unexpected request with no handler")
            return
        }
        
        do {
            let (response, data) = try handler(request)
            client?.urlProtocol(self, didReceive: response, 
                                cacheStoragePolicy: .notAllowed)
            client?.urlProtocol(self, didLoad: data)
            client?.urlProtocolDidFinishLoading(self)
        } catch {
            client?.urlProtocol(self, 
                                didFailWithError: error)
        }
    }
    override func stopLoading() { }
}
