//
//  NetworkManagerTests.swift
//  SchoolAppTests
//
//  Created by Mohsin Khawas on 10/13/19.
//  Copyright © 2019 Mohsin Khawas. All rights reserved.
//

import XCTest
@testable import SchoolApp

class NetworkManagerTests: XCTestCase {
    
    let networkManager = NetworkManager()
    
    func testFetchSchools() {
        
        let exp = expectation(description: "Success Response and fetch School List Data.")
        let testAPI = APIURLConstants.fetchSchools
        
        networkManager.fetchData(urlString: testAPI) { (resultData, error) in
            XCTAssertNil(error)
            
            guard let data = resultData,
                let response = try? JSONDecoder().decode(Array<School>.self, from: data as! Data) else {
                    exp.fulfill()
                    
                    return
            }
            
            XCTAssert(response.count > 0, "Schools fetched.")
            exp.fulfill()
        }
        
        waitForExpectations(timeout: 3.0, handler: nil)
    }
    
    func testFetchSATScores() {
        
        let exp = expectation(description: "Success Response and fetched SAT Scores Data.")
        let testAPI = APIURLConstants.fetchSATScores
        
        networkManager.fetchData(urlString: testAPI) { (resultData, error) in
            XCTAssertNil(error)
            
            guard let data = resultData,
                let response = try? JSONDecoder().decode(Array<SchoolSATScores>.self, from: data as! Data) else {
                    exp.fulfill()
                    
                    return
            }
            
            XCTAssert(response.count > 0, "SAT Scores fetched.")
            exp.fulfill()
        }
        
        waitForExpectations(timeout: 3.0, handler: nil)
    }
}
